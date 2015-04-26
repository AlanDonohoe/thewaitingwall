class WallsController < ApplicationController
  before_action :set_wall, only: [:show]
  before_action :get_current_batch, only: [:show]
  before_action :set_background

  # GET /walls/1
  # GET /walls/1.json
  def show
    respond_to do |format|
      format.js
      format.html { render layout: 'wall_layout' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wall
      @wall = Wall.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wall_params
      { background: params[:background] }
    end

    def get_current_batch
      @current_batch = Batch.last || Batch.create
    end

    def set_background
      # @show_image = (wall_params[:background].present? && 'show_image' == wall_params[:background]) ? true : false
      @colour = wall_params[:background].present? ? wall_params[:background] : 'black'
    end
end
