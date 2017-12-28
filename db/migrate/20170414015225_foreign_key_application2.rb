class ForeignKeyApplication2 < ActiveRecord::Migration
  def change
  	add_belongs_to :applications, :user
  end
end
