class AddColumnsToFormat < ActiveRecord::Migration
  def change
    add_column :formats, :published_at, :timestamp
    add_column :formats, :workflow_state, :string
  end
end
