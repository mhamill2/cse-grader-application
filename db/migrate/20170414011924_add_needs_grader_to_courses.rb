class AddNeedsGraderToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :grader_needed, :boolean
  end
end
