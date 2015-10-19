class AddInfoTextToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :info_text, :string
  end
end
