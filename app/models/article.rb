class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :sub_category
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }
  scope :top_rated, -> { order("rating desc") }

end
