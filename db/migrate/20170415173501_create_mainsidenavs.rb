class CreateMainsidenavs < ActiveRecord::Migration
  def change
    create_table :mainsidenavs do |t|

      t.string :title
      t.string :link

      t.timestamps null: false
    end
  end
end
