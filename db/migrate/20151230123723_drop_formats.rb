class DropFormats < ActiveRecord::Migration
  def change
  	drop_table :formats
  end
end
