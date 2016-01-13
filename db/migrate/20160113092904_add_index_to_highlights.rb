class AddIndexToHighlights < ActiveRecord::Migration
  def change
    add_index :highlights, :courseformat_id
  end
end
