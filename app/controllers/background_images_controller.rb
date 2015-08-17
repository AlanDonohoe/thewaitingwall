class BackgroundImagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]
  load_and_authorize_resource

  # GET /background_images
  # GET /background_images.json
  def index
    @background_images = BackgroundImage.all
    render layout: 'devise_layout' 
  end

  # GET /background_images/1
  # GET /background_images/1.json
  def show
    render layout: 'devise_layout' if current_user.present? && current_user.admin?
  end

  # GET /background_images/new
  def new
    @background_image = BackgroundImage.new
  end

  # POST /background_images
  # POST /background_images.json
  def create
    respond_to do |format|
      if @background_image.save
        format.html { redirect_to @background_image, notice: 'Image was successfully created.' }
        # format.json { render :show, status: :created, location: @background_image }
      else
        format.html { render :new }
        # format.json { render json: @background_image.errors, status: :unprocessable_entity }
      end
    end
  end
 
  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  # Need one set of params for create, that does not have approved and current user....
  # Need second set for update (which a user has to be signed in and admin to authorise) - which does have approved and current user
  def create_params
    params.require(:background_image).permit(:image)
  end
end
