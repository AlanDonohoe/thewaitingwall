CarrierWave.configure do |config|

  if Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["S3_ACCESS_KEY"],                        # required
    :aws_secret_access_key  => ENV["S3_SECRET_KEY"],                        # required
    :region                 => 'eu-west-1'                  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV["S3_STORAGE_BUCKET"]                    # required
    config.fog_public     = true                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    config.remove_previously_stored_files_after_update = false
  end
end
