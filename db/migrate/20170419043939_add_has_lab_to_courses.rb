class AddHasLabToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :has_lab, :boolean
  end
end
