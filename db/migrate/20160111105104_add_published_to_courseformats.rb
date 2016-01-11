class AddPublishedToCourseformats < ActiveRecord::Migration
  def change
    add_column :courseformats, :published_at, :timestamp
  end
end
