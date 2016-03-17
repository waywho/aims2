class Quote < ActiveRecord::Base

	include Workflow

	scope :published_now, -> { self.with_published_state.where('published_at <= ?', Time.zone.now)}
	has_many :recordfies, as: :entriable
	has_many :pages, through: :recordfies
	acts_as_xlsx
	
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
