class BackgroundImagesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :index]
  load_and_authorize_resource

  # GET /background_images
  # GET /background_images.json
  def index
    @background_images = BackgroundImage
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

  # GET /background_images/1/edit
  def edit
    render layout: 'devise_layout' 
  end

  # POST /background_images
  # POST /background_images.json
  def create
    # TODO delete approved params - so no one can hack in an approved message
    @background_image = BackgroundImage.new(message_params)

    respond_to do |format|
      if @background_image.save
        format.html { redirect_to @background_image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @background_image }
      else
        format.html { render :new }
        format.json { render json: @background_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /background_images/1
  # PATCH/PUT /background_images/1.json
  def update
    respond_to do |format|
      if @background_image.update(message_params)
        format.html { redirect_to @background_image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @background_image }
      else
        format.html { render :edit }
        format.json { render json: @background_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /background_images/1
  # DELETE /background_images/1.json
  def destroy
    # TODO Add paranoid gem to soft delete messages? and have a before delete to save current user_id
    @background_image.destroy
    respond_to do |format|
      format.html { redirect_to background_images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 
  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  # Need one set of params for create, that does not have approved and current user....
  # Need second set for update (which a user has to be signed in and admin to authorise) - which does have approved and current user
  def message_params
    params.require(:background_image).permit(:image)
  end
end
