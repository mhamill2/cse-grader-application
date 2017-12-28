class CreateGradesFors < ActiveRecord::Migration
  def change
    create_table :grades_fors do |t|
      t.integer :user_id
      t.integer :section

      t.timestamps null: false
    end
  end
end
