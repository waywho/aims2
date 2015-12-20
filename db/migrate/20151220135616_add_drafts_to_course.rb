class AddDraftsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :draft_id, :integer
    add_column :courses, :published_at, :timestamp
  end
end
