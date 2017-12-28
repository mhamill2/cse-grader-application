class RemoveCoursesAndGradeFromApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :grade, :integer
    remove_column :applications, :course, :integer
  end
end
