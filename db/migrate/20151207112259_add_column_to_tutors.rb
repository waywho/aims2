class AddColumnToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :photo, :string
  end
end
