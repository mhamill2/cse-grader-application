class UpdateLabTimes < ActiveRecord::Migration
  def change
    drop_table :has_lab_times
    add_column :lab_times, :course_id, :integer
  end
end
