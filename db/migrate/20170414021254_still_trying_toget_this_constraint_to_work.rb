class StillTryingTogetThisConstraintToWork < ActiveRecord::Migration
  def change
  	remove_belongs_to :applications, :user
  	remove_column :applications, :student_id
  	add_reference :applications, :user, foreign_key: true
  end
end
