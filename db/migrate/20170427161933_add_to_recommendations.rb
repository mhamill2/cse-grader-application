class AddToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :student_dot_number, :integer
    add_column :recommendations, :student_lname, :string
    remove_column :recommendations, :student_id, :integer
  end
end
