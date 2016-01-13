class AddFeaturePageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :feature_page, :boolean
  end
end
