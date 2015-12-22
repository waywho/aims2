class Course < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_drafts


	belongs_to :format
	has_many :klasses
	has_many :photos, as: :imageable
	accepts_nested_attributes_for :photos, allow_destroy: true

	def class_name
		self.class.name
	end

	def find_drafts
		draft.reify if self.draft?
	end
end
