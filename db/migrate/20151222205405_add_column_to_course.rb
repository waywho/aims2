class AddColumnToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :workflow_state, :string
  end
end
