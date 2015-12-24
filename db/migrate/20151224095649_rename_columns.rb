class RenameColumns < ActiveRecord::Migration
  def change
  	rename_column :courses, :name, :title
  	rename_column :klasses, :name, :title
  end
end
