class AddColumnsToAll < ActiveRecord::Migration
  def change
  	add_column :course_formats, :published_at, :datetime
  	add_column :courses, :published_at, :datetime
  	add_column :events, :published_at, :datetime
  	add_column :fees, :published_at, :datetime
  	add_column :klasses, :published_at, :datetime
  	add_column :pages, :published_at, :datetime
  	add_column :staffs, :published_at, :datetime
  	add_column :quotes, :published_at, :datetime
  end
end