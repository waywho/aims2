class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :author
      t.string :saying
      t.string :workflow_state

      t.timestamps null: false
    end
  end
end
