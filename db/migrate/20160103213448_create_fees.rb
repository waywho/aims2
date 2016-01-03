class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.string :fee_type
      t.string :category
      t.string :description
      t.integer :amount
      t.string :workflow_state
      t.belongs_to :commentable, polymorphic: true

      t.timestamps null: false
    end
  end
end
