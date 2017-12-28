class DropMainsidenav < ActiveRecord::Migration
  def change
  	drop_table :mainsidenavs
  end
end
