class Page < ActiveRecord::Base
	extend FriendlyId
	mount_uploader :feature_image, ImageUploader
	# before_save :falsify_all_others
	has_ancestry
	
	belongs_to :user
	friendly_id :title, use: :slugged
	has_paper_trail :on => [:update, :create, :destroy]
	scope :published_now, -> { self.with_published_state.where('published_at <= ?', Time.zone.now)}
	has_many :menus, as: :navigation, :dependent => :destroy
	has_many :recordfies
	has_many :courses, through: :recordfies, source: :entriable, source_type: 'Course'
	has_many :courseformats, through: :recordfies, source: :entriable, source_type: 'Courseformat'
	has_many :events, through: :recordfies, source: :entriable, source_type: 'Event'
	has_many :fees, through: :recordfies, source: :entriable, source_type: 'Fee'
	has_many :klasses, through: :recordfies, source: :entriable, source_type: 'Klass'
	has_many :quotes, through: :recordfies, source: :entriable, source_type: 'Quote'
	has_many :staffs, through: :recordfies, source: :entriable, source_type: 'Staff'
	
	acts_as_xlsx
	acts_as_taggable_on :keywords

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

	# def falsify_all_others
	# 	self.class.where('id != ? AND feature').update_all("feature = 'false'")
	# end

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |item|
				csv << item.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			item = find_by_id(row["id"]) || new
			item.attributes = row.to_hash.slice(*self.column_names)
			item.save!
		end
	end
end
