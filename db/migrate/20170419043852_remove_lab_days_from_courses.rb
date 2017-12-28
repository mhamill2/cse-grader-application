class RemoveLabDaysFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :lab_days, :string
  end
end
