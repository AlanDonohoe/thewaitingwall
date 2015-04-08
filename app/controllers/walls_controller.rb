class WallsController < ApplicationController
  before_action :set_wall, only: [:show]
  before_action :get_current_batch_of_messages, only: [:show]

  # GET /walls/1
  # GET /walls/1.json
  def show
    render layout: 'wall_layout'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wall
      @wall = Wall.first # was: params[:id] - but like Highlander, there can be only one wall.
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wall_params
      params[:wall]
    end

    def get_current_batch_of_messages
      @current_batch_of_messages = Message.approved_messages
    end
end
