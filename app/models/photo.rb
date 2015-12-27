class Photo < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	scope :unassigned, -> { where(imageable: nil) }

	mount_uploader :image, ImageUploader


	# def self.multiple_save(object, photo_attribute_params)
 #    	photo_attribute_params['image'].each do |image|
 #      		object.photos.create(image: image)
 #    	end
 #  	end

end
