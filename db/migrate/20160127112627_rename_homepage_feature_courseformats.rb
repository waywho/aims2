class RenameHomepageFeatureCourseformats < ActiveRecord::Migration
  def change
  	rename_column :courseformats, :homepage_feature, :feature
  	rename_column :pages, :feature_page, :feature
  end
end
