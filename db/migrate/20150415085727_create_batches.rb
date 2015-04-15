class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.references :message, index: true

      t.timestamps null: false
    end
    add_foreign_key :batches, :messages
  end
end
