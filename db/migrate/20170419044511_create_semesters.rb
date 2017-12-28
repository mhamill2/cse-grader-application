class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :semester
      t.integer :year
      t.integer :semester_id

      t.timestamps null: false
    end
  end
end
