class CreateRecordfies < ActiveRecord::Migration
  def change
    create_table :recordfies do |t|
      t.integer :page_id
      t.belongs_to :entriable, polymorphic: true
      t.integer :row_order

      t.timestamps null: false
    end

    add_index :recordfies, [:entriable_type, :entriable_id]
    add_index :recordfies, :row_order
  end

end
