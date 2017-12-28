class AddLabDaysToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :lab_days, :string
  end
end
