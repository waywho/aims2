class Format < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	
	has_many :courses
	has_many :photos, as: :imageable
	accepts_nested_attributes_for :photos, allow_destroy: true
	
	has_paper_trail :on => [:update, :create, :destroy]
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
	
	def publish
		update_attribute(:published_at, Time.now)
	end

end
