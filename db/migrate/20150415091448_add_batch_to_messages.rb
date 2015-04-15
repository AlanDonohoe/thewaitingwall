class AddBatchToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :batch, index: true
    add_foreign_key :messages, :batches
  end
end
