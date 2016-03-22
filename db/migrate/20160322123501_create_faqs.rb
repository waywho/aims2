class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text :question
      t.text :answer
      t.string :workflow_state
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
