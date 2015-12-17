class Tutor < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	GlobalID::Identification

	has_one :photo, as: :imageable
end
