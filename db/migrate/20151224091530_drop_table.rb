class DropTable < ActiveRecord::Migration
  def change
  	drop_table :accompanists
  	drop_table :tutors
  end
end
