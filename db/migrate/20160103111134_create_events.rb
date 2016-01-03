class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.text :programme
      t.text :performers
      t.datetime :date
      t.string :slug

      t.timestamps null: false
    end
  end
end
