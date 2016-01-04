class RemoveColumnFromStaffs < ActiveRecord::Migration
  def change
    remove_column :staffs, :photo, :string
  end
end
