class Photo < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	scope :unassigned, -> { where(imageable: nil) }

	mount_uploader :image, ImageUploader
	
	def class_name
		self.class.name
	end

end
