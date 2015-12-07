class AddSlugToAccompanists < ActiveRecord::Migration
  def change
    add_column :accompanists, :slug, :string
    add_index :accompanists, :slug
  end
end
