class RenameStudentIdToUserId < ActiveRecord::Migration
  def change
  	remove_column :schedules, :student_id
  	add_column :schedules, :user_id, :integer
  end
end
