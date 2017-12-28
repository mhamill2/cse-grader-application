class RemoveSemesterYearFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :semester, :string
    remove_column :courses, :year, :integer
  end
end
