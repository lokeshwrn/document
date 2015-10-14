class SubCategory < ActiveRecord::Base

  has_many :articles
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true

end
