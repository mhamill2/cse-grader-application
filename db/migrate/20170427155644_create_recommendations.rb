class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :student_id
      t.integer :instructor_id
      t.integer :course_number
      t.text :comments

      t.timestamps null: false
    end
  end
end
