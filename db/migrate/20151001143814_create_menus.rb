class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :alias_name
      t.integer :parent_id
      t.string :controller
      t.string :action
      t.boolean :status, :default => false
      t.string :access
      t.string :page_no
      t.string :sequence_number
      t.string :url

      t.timestamps null: false
    end
  end
end

