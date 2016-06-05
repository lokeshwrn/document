class SubCategory < ActiveRecord::Base

  class << self
    include ApplicationHelper
  end

  has_many :articles
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :by_favs, -> {where('favourite = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }

  def self.top_by_count
    self.all.sort{|x,y| y.articles.count <=> x.articles.count}
  end

  def self.get_favourites
    fetch_values(SubCategory.by_favs.first(6), "url_helpers.articles_path(y.id)")
  end

  def self.get_toppers
    fetch_values(SubCategory.top_by_count.first(6), "url_helpers.articles_path(y.id)")
  end

  def self.get_search(value)
    sub_category=SubCategory.where("name LIKE ? OR description LIKE ?", "%#{value}%", "%#{value}%").uniq
    fetch_values(sub_category, "url_helpers.articles_path(y.id)")
  end

end
