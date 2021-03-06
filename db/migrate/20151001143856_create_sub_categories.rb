class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :name
      t.string :description
      t.integer :category_id
      t.boolean :status, :default => false
      t.boolean :favourite

      t.timestamps null: false
    end
  end
end
