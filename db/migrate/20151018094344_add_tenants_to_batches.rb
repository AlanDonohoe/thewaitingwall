class AddTenantsToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :tenant_id, :integer
    add_index :batches, :tenant_id
  end
end
