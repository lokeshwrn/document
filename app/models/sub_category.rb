class SubCategory < ActiveRecord::Base

  has_many :articles
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }

  def self.top_by_count
    self.all.sort{|x,y| y.articles.count <=> x.articles.count}
  end

end
