class AddSemesterIdToSchedule < ActiveRecord::Migration
  def change
  	add_column :schedules, :semester_id, :integer
  end
end
