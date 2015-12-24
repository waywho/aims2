class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.text :biography
      t.string :role
      t.string :photo
      t.string :slug
      t.timestamp :published_at
      t.string :workflow_state

      t.timestamps null: false
    end
  end
end
