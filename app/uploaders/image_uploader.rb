# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  
  #include CarrierWave::Compatibility::Paperclip

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #'public/my/upload/directory'
    #"carrierwave/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    "/images/noimage.png"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  # 
  # def scale(width, height)
  #    # do something
  # end
  
  # process :do_stuff => 10.0
  # 
  # def do_stuff(blur_factor)
  #   manipulate! do |img|
  #     img = img.sepiatone
  #     img = img.auto_orient
  #     img = img.radial_blur(blur_factor)
  #   end
  # end

  # Create different versions of your uploaded files:
  version :small do
     process :resize_to_fit => [150, 300]
     process :croppy => [::Magick::CenterGravity, 100, 100]
     #process :scale => [100, 100]
  end
  
  version :medium do
    process :resize_to_fit => [300, 600]
    process :croppy => [::Magick::CenterGravity, 300, 200]
  end
  
  version :large do
    process :resize_to_fit => [500, 1_000]
    process :croppy => [::Magick::CenterGravity, 500, 330]
  end
  
  def croppy(g, w, h)
    manipulate! do |img|
      img = img.crop(g, w, h)
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

end
