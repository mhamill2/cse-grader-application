class CreateUser2s < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.integer :dot_number
      t.integer :buck_id
      t.string :email
      t.string :password_digest
      t.integer :role
      t.timestamps null: false
    end
  end
end
