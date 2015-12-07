class AddSlugToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :slug, :string
    add_index :tutors, :slug
  end
end
