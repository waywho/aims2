class AddFeatureToCourseformats < ActiveRecord::Migration
  def change
    add_column :courseformats, :homepage_feature, :boolean
  end
end
