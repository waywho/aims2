class AddRowsToMany < ActiveRecord::Migration
  def change
  	add_column :courseformats, :row_order, :integer
  	add_column :courses, :row_order, :integer
  	add_column :highlights, :row_order, :integer
  	add_column :klasses, :row_order, :integer

  	add_index :courseformats, :row_order
  	add_index :courses, :row_order
  	add_index :highlights, :row_order
  	add_index :klasses, :row_order
  end
end
