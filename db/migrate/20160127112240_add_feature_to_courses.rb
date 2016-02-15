class AddFeatureToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :feature, :boolean
  end
end
