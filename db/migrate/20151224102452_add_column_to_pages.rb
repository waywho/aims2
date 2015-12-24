class AddColumnToPages < ActiveRecord::Migration
  def change
    add_column :pages, :published_at, :timestamp
    add_column :pages, :workflow_state, :string
  end
end
