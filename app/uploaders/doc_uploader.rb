# encoding: utf-8

class DocUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :aws
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "downloads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def download_url(filename)
    url(response_content_disposition: %Q{attachment; filename="#{filename}"})
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb, :if => :pdf? do
    process :cover
    process :resize_to_fit => [200, 282.8]
    process :convert => :jpg
    # process :set_content_type

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end

  # def set_content_type(*args)
  #   self.file.instance_variable_set(:@content_type, "image/jpeg")
  # end

  def cover
    manipulate! do |frame, index|
      frame if index.zero?
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(docx doc pdf)
  end

  protected

  def pdf?(file)
    file.content_type.start_with? 'application/pdf'
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
