class AddColumnToKlasses < ActiveRecord::Migration
  def change
    add_column :klasses, :published_at, :timestamp
    add_column :klasses, :workflow_state, :string
  end
end
