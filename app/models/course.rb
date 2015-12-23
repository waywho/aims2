class Course < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_paper_trail
	include Workflow


	belongs_to :format
	has_many :klasses
	has_many :photos, as: :imageable
	accepts_nested_attributes_for :photos, allow_destroy: true

	def class_name
		self.class.name
	end

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

	def self.states
		workflow_spec.state_names
	end
end
