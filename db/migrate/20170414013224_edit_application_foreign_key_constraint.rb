class EditApplicationForeignKeyConstraint < ActiveRecord::Migration
  def change
  	remove_column :applications, :course
  	add_column :applications, :course, :integer
  	add_foreign_key :applications, :users, column: :student_id
  end
end
