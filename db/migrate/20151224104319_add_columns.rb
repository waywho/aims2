class AddColumns < ActiveRecord::Migration
  def change
  	add_column :formats, :whats_new, :text
  	add_column :formats, :when_from, :datetime
  	add_column :formats, :when_to, :datetime
  	add_column :formats, :venue, :string
  	add_column :formats, :address1, :string
  	add_column :formats, :address2, :string
  	add_column :formats, :city, :string
  	add_column :formats, :county, :string
  	add_column :formats, :country, :string
  	add_column :formats, :post_code, :string
  end
end
