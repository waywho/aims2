class Format < ActiveRecord::Base
	has_many :courses
	has_many :photos, as: :imageable
	# friendly_id :name, use: :slugged

end
