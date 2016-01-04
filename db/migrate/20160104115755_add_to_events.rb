class AddToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :ticket_type, :string
  end
end
