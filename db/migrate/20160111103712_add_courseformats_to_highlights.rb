class AddCourseformatsToHighlights < ActiveRecord::Migration
  def change
    add_column :highlights, :courseformat_id, :integer
  end
end
