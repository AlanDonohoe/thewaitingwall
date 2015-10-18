class AddTenantsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :tenant_id, :integer
    add_index :messages, :tenant_id
  end
end
