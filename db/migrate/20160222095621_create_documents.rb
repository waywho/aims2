class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :caption
      t.text :description
      t.string :file

      t.timestamps null: false
    end
  end
end
