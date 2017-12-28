class AddInstructorIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :instructor_id, :integer
  end
end
