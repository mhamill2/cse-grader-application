class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :student_id
      t.string :course
      t.integer :grade
      t.timestamps null: false
    end
  end
end
