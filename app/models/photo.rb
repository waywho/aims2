class Photo < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	scope :unassigned, -> { where(imageable: [nil, ""]) }
	before_create :default_name
	acts_as_xlsx

	mount_uploader :image, ImageUploader

	def default_name
		self.caption ||= File.basename(image.filename, '.*').titleize if image
	end

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |item|
				csv << item.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			item = find_by_id(row["id"]) || new
			item.attributes = row.to_hash.slice(*self.column_names)
			item.save!
		end
	end


	# def self.multiple_save(object, photo_attribute_params)
 #    	photo_attribute_params['image'].each do |image|
 #      		object.photos.create(image: image)
 #    	end
 #  	end

end
