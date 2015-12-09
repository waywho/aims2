class AddIndexToPhoto < ActiveRecord::Migration
  def change
    add_index :photos, :imageable_type
  end
end
