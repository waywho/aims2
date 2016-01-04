class ChangeColumnsFees < ActiveRecord::Migration
  def change
  	remove_column :fees, :eventable_id
  	remove_column :fees, :eventable_type
  	add_column :fees, :course_format_id, :integer
  	add_index :fees, :course_format_id
  end
end
