class CreateHasLabTimes < ActiveRecord::Migration
  def change
    create_table :has_lab_times do |t|
      t.integer :section
      t.integer :lab_time_id

      t.timestamps null: false
    end
  end
end
