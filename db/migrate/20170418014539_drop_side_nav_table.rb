class DropSideNavTable < ActiveRecord::Migration
  def change
  	drop_table :main_side_navs
  end
end
