class Accompanist < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_one :photo, as: :imageable
end
