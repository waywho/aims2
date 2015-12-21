class AddColumnToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :published_at, :timestamp
  end
end
