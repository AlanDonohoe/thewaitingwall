class BackgroundImage < ActiveRecord::Base
  mount_uploader :image, BackgroundImageUploader
  belongs_to :batch
  # def image_url
  #   image.url
  # end
end

class UnsetBackgroundImage
  def image_url # give them some default that isnt a blank screen
    "https://wallbackgroundimages.s3.amazonaws.com/uploads/background_image/image/22/a_IMG_3338.jpg"
  end
end
