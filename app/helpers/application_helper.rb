module ApplicationHelper
  def append_current_tenant_subdomain_url(original_url)
    Tenant.append_guest_url?(current_tenant.subdomain) ? original_url + "?guest=#{current_tenant.subdomain}" : original_url
  end
end
