class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :prevent_xhr_caching
  before_action :current_tenant

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def prevent_xhr_caching
    return unless request.xhr?
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def current_tenant
    Tenant.using_subdomain_for_tenants? ? subdomain = request.subdomain : subdomain = params[:guest]
    puts 'subdomain ' + subdomain.inspect
    subdomain = '' if subdomain.nil? || 'www' == subdomain
    tenant = Tenant.find_by_subdomain subdomain # default tenant has empty subdomain string - so this will be served if user visits site with no subdomain...
    puts ' tenant    - - - ' + tenant.inspect
    return tenant.nil? ? Tenant.default_tenant : tenant
  end

  def append_current_tenant_subdomain_url(original_url)
    Tenant.append_guest_url?(current_tenant.subdomain) ? original_url + "?guest=#{current_tenant.subdomain}" : original_url
  end

  helper_method :current_tenant # if we need to use the tenant in the views
end
