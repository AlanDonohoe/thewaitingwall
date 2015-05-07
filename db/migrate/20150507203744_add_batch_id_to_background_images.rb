class AddBatchIdToBackgroundImages < ActiveRecord::Migration
  def change
    add_column :background_images, :batch_id, :integer
  end
end
