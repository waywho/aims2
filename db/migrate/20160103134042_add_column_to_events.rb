class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :workflow_state, :string
  end
end
