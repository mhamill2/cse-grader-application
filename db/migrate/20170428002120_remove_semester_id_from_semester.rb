class RemoveSemesterIdFromSemester < ActiveRecord::Migration
  def change
    remove_column :semesters, :semester_id, :integer
  end
end
