class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_back fallback_location: root_path and return
    end
    render layout: "layouts/devise_layout"
  end
end
