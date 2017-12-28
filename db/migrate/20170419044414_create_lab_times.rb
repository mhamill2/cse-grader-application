class CreateLabTimes < ActiveRecord::Migration
  def change
    create_table :lab_times do |t|
      t.string :day
      t.time :start_time
      t.time :end_time
      t.integer :lab_time_id

      t.timestamps null: false
    end
  end
end
