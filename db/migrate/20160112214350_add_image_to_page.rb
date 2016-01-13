class AddImageToPage < ActiveRecord::Migration
  def change
    add_column :pages, :feature_image, :string
  end
end
