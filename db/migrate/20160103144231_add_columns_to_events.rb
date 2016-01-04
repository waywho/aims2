class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :venue, :string
    add_column :events, :address1, :string
    add_column :events, :address2, :string
    add_column :events, :city, :string
    add_column :events, :county, :string
    add_column :events, :country, :string
    add_column :events, :post_code, :string
  end
end
