class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.boolean :current_semester
      t.boolean :next_semester
      t.integer :section

      t.timestamps null: false
    end
  end
end
