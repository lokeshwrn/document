class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email_id
      t.string :password
      t.string :secret
      t.string :role, :default => "users"
      t.boolean :status, :default => false
      t.integer :user_property_id

      t.timestamps null: false
    end
  end
end
