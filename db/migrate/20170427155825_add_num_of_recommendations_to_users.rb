class AddNumOfRecommendationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :num_of_recommends, :integer
  end
end
