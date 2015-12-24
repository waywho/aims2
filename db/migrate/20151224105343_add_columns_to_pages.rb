class AddColumnsToPages < ActiveRecord::Migration
  def change
  	add_column :pages, :leader_id, :integer
  	add_column :pages, :leader_type, :integer
  	add_index :pages, :leader_id
  	add_index :pages, :leader_type
  end
end
