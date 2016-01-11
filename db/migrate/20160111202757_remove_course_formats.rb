class RemoveCourseFormats < ActiveRecord::Migration
  def change
  	drop_table :course_formats
  end
end
