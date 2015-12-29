class Staff < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	scope :tutor, -> { where(role: "tutor") }
	scope :house_pianist, -> { where(role: "house pianist") }
	scope :admin, -> { where(role: "admin") }
	has_paper_trail :on => [:update, :create, :destroy]

	ROLES = ["tutor", "house pianist", "Artistic Director", "General Manager", "Admin"]

	has_one :photo, as: :imageable
	accepts_nested_attributes_for :photo, allow_destroy: true

	include Workflow

	workflow do
		state :draft do
			event :submit, transition_to: :pending_review
			event :approve, transition_to: :approved
			event :publish, transition_to: :published
		end

		state :pending_review do
			event :approve, transition_to: :approved
			event :reject, transition_to: :draft
			event :publish, transition_to: :published
		end

		state :approved do
			event :publish, transition_to: :published
			event :reject, transition_to: :draft
		end

		state :published do
			event :unpublish, transition_to: :draft
		end
	end

	def publish
		update_attribute(:published_at, Time.now)
	end
end
