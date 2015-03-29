class WallsController < ApplicationController
  before_action :set_wall, only: [:show]
  before_action :get_approved_messages, only: [:show]

  # GET /walls/1
  # GET /walls/1.json
  def show
    render layout: 'wall_layout'
  end

  # GET /walls/new
  def new
    @wall = Wall.new
  end

  # POST /walls
  # POST /walls.json
  def create
    @wall = Wall.new(wall_params)

    respond_to do |format|
      if @wall.save
        format.html { redirect_to @wall, notice: 'Wall was successfully created.' }
        format.json { render :show, status: :created, location: @wall }
      else
        format.html { render :new }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
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

    def get_approved_messages
      @approved_messages = Message.least_shown_approved_messages
    end
end
