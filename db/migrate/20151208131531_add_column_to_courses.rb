class AddColumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :format_id, :integer
    add_index :courses, :format_id
  end
end
