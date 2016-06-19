class ChangeRatingDataType < ActiveRecord::Migration
  def change
    change_column :articles, :rating,  :float
  end
end
