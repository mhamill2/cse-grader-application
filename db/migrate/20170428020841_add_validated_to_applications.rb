class AddValidatedToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :validated, :boolean
  end
end
