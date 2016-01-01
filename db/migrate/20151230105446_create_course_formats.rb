class CreateCourseFormats < ActiveRecord::Migration
  def change
    create_table :course_formats do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.string :workflow_state
      t.text :whats_new
      t.datetime :when_from
      t.datetime :when_to
      t.string :venue
      t.string :address1
      t.string :address2
      t.string :city
      t.string :county
      t.string :country
      t.string :post_code

      t.timestamps null: false
    end
    add_index :course_formats, :slug
  end
end
