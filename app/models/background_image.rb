class BackgroundImage < ActiveRecord::Base
  mount_uploader :image, BackgroundImageUploader
  belongs_to :batch
end
