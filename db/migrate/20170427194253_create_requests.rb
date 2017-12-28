class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :course_number
      t.integer :section
      t.string :student_lname
      t.integer :student_dot_number

      t.timestamps null: false
    end
  end
end
