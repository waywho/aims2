class AddColumnToMenus < ActiveRecord::Migration
  def change
  	add_column :menus, :menu_type, :string
    add_column :menus, :navigation_type, :string
    add_column :menus, :navigation_id, :integer
    add_index :menus, :navigation_type
    add_index :menus, :navigation_id
  end
end
