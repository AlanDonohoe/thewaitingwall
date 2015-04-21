class AddInitialMessages < ActiveRecord::Migration
  def change
    Message.add_initial_messages
  end
end