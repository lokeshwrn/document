class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :alias_name
      t.string :status, :default => false
      t.boolean :favourite

      t.timestamps null: false
    end
  end
end
