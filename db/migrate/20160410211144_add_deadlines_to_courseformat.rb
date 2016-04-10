class AddDeadlinesToCourseformat < ActiveRecord::Migration
  def change
  	add_column :courseformats, :application_deadline, :datetime
  	add_column :courseformats, :first_payment_date, :datetime
  	add_column :courseformats, :second_payment_date, :datetime
  	add_column :courseformats, :audition_date, :datetime
  end
end
