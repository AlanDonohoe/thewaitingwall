class WallsController < ApplicationController
  before_action :set_wall, only: [:show]
  before_action :get_current_batch, only: [:show]
  before_action :set_show_link, only: [:show]

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

  def set_show_link
    show_link = params.permit(:show_link).present? ? true : false
    @link = {}
    if show_link
      @link[:link_text] = 'thewaitingwall.com'
      @link[:link_anchor] = 'http://www.thewaitingwall.com'
      @link[:wrapper_class] = "col s2 offset-s10"
    else
      @link[:link_text] = 'write message'
      @link[:link_anchor] = 'messages/new'
      @link[:wrapper_class] = "col s2 offset-s10"
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wall_params
    params.permit(:show_link)
  end

  def get_current_batch
    @current_batch = Batch.last || Batch.create
  end
end
