class AlterCourseformatidCourses < ActiveRecord::Migration
  def change
  	remove_column :courses, :course_format_id
  	add_column :courses, :courseformat_id, :integer
  	remove_column :fees, :course_format_id
  	add_column :fees, :courseformat_id, :integer

  	add_index :courses, :courseformat_id
  	add_index :fees, :courseformat_id
  end
end
