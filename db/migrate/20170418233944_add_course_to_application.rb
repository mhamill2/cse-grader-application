class AddCourseToApplication < ActiveRecord::Migration
  def change
  	add_column :applications, :course_number, :integer
  end
end
