class Staff < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	scope :tutor, -> { where(role: "tutor") }
	scope :accompanist, -> { where(role: "accompanist") }
	scope :admin, -> { where(role: "admin") }
	has_paper_trail :on => [:update, :create, :destroy]

	ROLES = ["tutor", "accompanist", "Artistic Director", "General Manager", "Admin"]

	has_one :photo, as: :imageable

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

		state :published
	end
end
