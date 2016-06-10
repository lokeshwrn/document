class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :article_tags do |t|
      t.integer :article_id
      t.integer :tag_id
      t.boolean :status, :default => false
      t.boolean :favourite

      t.timestamps null: false
    end
  end
end
