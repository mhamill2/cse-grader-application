class AddYearToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :year, :integer
  end
end
