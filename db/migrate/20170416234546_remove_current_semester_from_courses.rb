class RemoveCurrentSemesterFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :current_semester, :boolean
    remove_column :courses, :next_semester, :boolean
  end
end
