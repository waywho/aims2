class Event < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
	has_paper_trail :on => [:update, :create, :destroy]
	has_one :photo, as: :imageable
	accepts_nested_attributes_for :photo, allow_destroy: true
	scope :published_now, -> { self.with_published_state.where('published_at <= ?', Time.zone.now)}
	scope :future, -> { published_now.where('date >= ?', Date.today)}
	has_many :recordfies, as: :entriable
	has_many :pages, through: :recordfies
	accepts_nested_attributes_for :pages, allow_destroy: true
	validates :address1, presence: true
	validates :city, presence: true
	validates :post_code, presence: true

	include Workflow

	acts_as_taggable_on :keywords

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

	def address
		address = "#{self.address1}, "
		address << "#{self.address2}, " if !self.address2.blank?
		address << "#{self.city}, " if !self.city.blank?
		address << " #{self.county}, " if !self.county.blank?
		address << " #{self.country}" if !self.country.blank?
		address << "#{self.post_code}" if !self.post_code.blank?
		address
	end
end
