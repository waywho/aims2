class RemoveColumns < ActiveRecord::Migration
  def change
  	remove_column :klasses, :published_at
  	remove_column :courses, :published_at
  	remove_column :pages, :published_at
  	remove_column :staffs, :published_at
  end
end
