class Event < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	has_paper_trail :on => [:update, :create, :destroy]
	has_one :photo, as: :imageable
	accepts_nested_attributes_for :photo, allow_destroy: true
	scope :published_now, -> { self.with_published_state.where('published_at <= ?', Time.zone.now)}
	scope :future, -> { published_now.where('date <= ?', Time.zone.now)}
	has_many :recordfies, as: :entriable
	has_many :pages, through: :recordfies

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
			event :submit, transition_to: :pending_review
			event :reject, transition_to: :draft
		end

		state :published do
			event :unpublish, transition_to: :draft
		end
	end
	
	def self.states
		workflow_spec.state_names
	end

	def publish
		update_attribute(:published_at, Time.zone.now) if self.published_at.nil?
	end

	def unpublish
		update_attribute(:published_at, nil)
	end
end
