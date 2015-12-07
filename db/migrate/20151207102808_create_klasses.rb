class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
    	t.string :name
    	t.text :description
    	t.text :repertoire
    	t.integer :number_of_sessions
    	t.string :session_of_day
    	t.integer :course_id

      t.timestamps null: false
    end
    add_index :klasses, :course_id
  end
end
