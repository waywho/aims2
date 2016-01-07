class AddRowOrderToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :row_order, :integer
    add_index :menus, :row_order
  end
end
