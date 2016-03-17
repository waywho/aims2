class Photo < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	scope :unassigned, -> { where(imageable: [nil, ""]) }
	before_create :default_name

	mount_uploader :image, ImageUploader

	def default_name
		self.caption ||= File.basename(image.filename, '.*').titleize if image
	end


	# def self.multiple_save(object, photo_attribute_params)
 #    	photo_attribute_params['image'].each do |image|
 #      		object.photos.create(image: image)
 #    	end
 #  	end

end
