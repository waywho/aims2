class AddProductCodeToFees < ActiveRecord::Migration
  def change
    add_column :fees, :product_code, :string
  end
end
