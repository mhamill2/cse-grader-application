class RemoveCommentsFromApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :comments, :text
  end
end
