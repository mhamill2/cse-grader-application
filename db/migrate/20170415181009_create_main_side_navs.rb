class CreateMainSideNavs < ActiveRecord::Migration
  def change
    create_table :main_side_navs do |t|

      t.string :title
      t.string :link

      t.timestamps null: false
    end
  end
end
