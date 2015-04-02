class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :index]
  load_and_authorize_resource

  # GET /messages
  # GET /messages.json
  def index
    # TODO list meesages by most recent and not approved.
    # @messages = Message.all
    # @messages = Message.accessible_by(current_ability)
    render layout: 'devise_layout' 
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    render layout: 'devise_layout' if current_user.present? && current_user.admin?
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
    render layout: 'devise_layout' 
  end

  # POST /messages
  # POST /messages.json
  def create
    # TODO delete approved params - so no one can hack in an approved message
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    # TODO Add paranoid gem to soft delete messages? and have a before delete to save current user_id
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    # Need one set of params for create, that does not have approved
    # Need second set for update (which a user has to be signed in and admin to authorise) - which does have approved...
    def message_params
      params.require(:message).permit(:message_text, :approved, :times_shown).merge(user_id: current_user.id)
    end
end
