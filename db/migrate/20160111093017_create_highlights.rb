class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.string :title
      t.string :description
      t.belongs_to :course_format, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
