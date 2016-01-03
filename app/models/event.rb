class Event < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	has_paper_trail :on => [:update, :create, :destroy]
	has_one :photo, as: :imageable
	accepts_nested_attributes_for :photo, allow_destroy: true
	has_one :fee, as: :eventable

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

	def self.states
		workflow_spec.state_names
	end
end
