class AddCommentsToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :comments, :text
  end
end
