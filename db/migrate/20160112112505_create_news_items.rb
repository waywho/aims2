class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :description
      t.string :workflow_state
      t.string :slug
      t.belongs_to :user
      t.timestamp :published_at

      t.timestamps null: false
    end
  end
end
