class DropTableDraft < ActiveRecord::Migration
  def change
  	drop_table :drafts
  	remove_column :courses, :draft_id
  end
end
