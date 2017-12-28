class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|

    	t.integer :student_id, null: false
    	t.integer :day, null: false
    	t.time :start_time, null: false
    	t.time :end_time, null: false


      	t.timestamps null: false
    end
  end
end
