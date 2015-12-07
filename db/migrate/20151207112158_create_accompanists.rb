class CreateAccompanists < ActiveRecord::Migration
  def change
    create_table :accompanists do |t|
    	t.string :name
      	t.text :biography
      	t.string :photo

      t.timestamps null: false
    end
  end
end
