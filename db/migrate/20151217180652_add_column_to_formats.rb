class AddColumnToFormats < ActiveRecord::Migration
  def change
    add_column :formats, :slug, :string
    add_index :formats, :slug
  end
end
