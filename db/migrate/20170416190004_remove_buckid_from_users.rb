class RemoveBuckidFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :buck_id, :integer
  end
end
