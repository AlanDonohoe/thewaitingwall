class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :subdomain

      t.timestamps null: false
    end
    Tenant.create(name: '', subdomain: '') # default tenant...
  end
end
