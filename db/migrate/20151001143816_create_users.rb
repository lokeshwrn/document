class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :email_id
      t.string :password
      t.integer :phone
      t.boolean :status
      t.datetime :last_login
      t.string :password_secret
      t.string :unicode_data
      t.string :role
      t.string :reset_code

      t.timestamps null: false
    end
  end
end
