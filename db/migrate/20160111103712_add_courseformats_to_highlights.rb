class AddCourseformatsToHighlights < ActiveRecord::Migration
  def change
    add_column :highlights, :courseformat_id, :integer
  	remove_column :highlights, :course_format_id
  end
end
