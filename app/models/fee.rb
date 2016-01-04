class Fee < ActiveRecord::Base
	belongs_to :course_format
	has_paper_trail :on => [:update, :create, :destroy]


	scope :event, -> {where(fee_type: 'Event')}
	
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
	
	def full_description
		"#{self.description}, £#{self.amount}" 
	end
	def self.states
		workflow_spec.state_names
	end
end
