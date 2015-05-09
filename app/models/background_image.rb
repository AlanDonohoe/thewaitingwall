class BackgroundImage < ActiveRecord::Base
  mount_uploader :image, BackgroundImageUploader
  belongs_to :batch
  # def image_url
  #   image.url
  # end
end

class UnsetBackgroundImage
  def image_url
    ''
  end
end
