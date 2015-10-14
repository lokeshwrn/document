class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :sub_category
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true

end
