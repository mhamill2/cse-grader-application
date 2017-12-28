class RemoveYearFromApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :year, :integer
  end
end
