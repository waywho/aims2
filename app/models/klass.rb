class Klass < ActiveRecord::Base
	belongs_to :course
	has_paper_trail :on => [:update, :create, :destroy]
	scope :published_now, -> { self.with_published_state.where('published_at <= ?', Time.zone.now)}
	has_many :recordfies, as: :entriable
	has_many :pages, through: :recordfies
	
	include RankedModel
	ranks :row_order, :with_same => :course_id

	include Workflow

	SESSIONS = ["Session 1", "Session 2", "Session 3", "Session 4"]

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
