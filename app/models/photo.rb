class Photo < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true

	mount_uploader :image, ImageUploader
	
	def class_name
		self.class.name
	end

	# def imageable_collection
	# 	Photo.reflect_on_all_associations(:belongs_to)
	# end
end
