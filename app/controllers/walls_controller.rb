class WallsController < ApplicationController
  before_action :set_wall, only: [:show]
  before_action :get_current_batch, only: [:show]
  before_action :set_show_link, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:show]

  # GET /walls/1
  # GET /walls/1.json
  def show
    respond_to do |format|
      format.html { render layout: 'wall_layout' }
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_wall
    # @wall = Wall.first
    @wall = Wall.new
  end

  def set_show_link
    @public_view = params.permit(:public_view).present? ? true : false
    @link = {}
    if @public_view
      @link[:link_text] = 'thewaitingwall.com'
      @link[:link_anchor] = 'http://www.thewaitingwall.com'
    else
      @link[:link_text] = 'write message'
      @link[:link_anchor] = 'messages/new'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wall_params
    params.permit(:public_view)
  end

  def get_current_batch
    @current_batch = current_tenant.batches.includes(:background_images, :messages).last || current_tenant.batches.create
  end
end
