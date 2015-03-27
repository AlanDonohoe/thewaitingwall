class RegistrationsController < Devise::RegistrationsController

  def new
    # redirect_to root_path
    redirect_to new_user_session_path 
  end

  protected

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end