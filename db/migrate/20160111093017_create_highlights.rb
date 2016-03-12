class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
