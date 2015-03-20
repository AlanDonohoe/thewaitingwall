class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message_text
      t.boolean :approved, default: false
      t.integer :times_shown, default: 0

      t.timestamps null: false
    end
  end
end
