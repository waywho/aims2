class ChangeColumnsCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :course_format_id, :integer
  	remove_column :courses, :format_id
  end
end
