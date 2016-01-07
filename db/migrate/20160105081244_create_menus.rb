class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :ancestry

      t.timestamps null: false
    end
    add_index :menus, :ancestry
  end
end
