class Article < ActiveRecord::Base

  class << self
    include ApplicationHelper
  end

  belongs_to :user
  belongs_to :sub_category
  has_many :comments
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :by_favs, -> {where('favourite = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }
  scope :top_rated, -> { order("rating desc") }

  def category
    self.sub_category.category
  end

  def self.get_favourites
    fetch_values(Article.by_favs.first(6), "url_helpers.show_article_path(y.id)")
  end

  def self.get_toppers
    fetch_values(Article.top_rated.first(6), "url_helpers.show_article_path(y.id)")
  end

  def self.get_search(value)
    article=Article.where("title LIKE ? or description LIKE ? OR content LIKE ?", "%#{value}%", "%#{value}%", "%#{value}%").uniq
    fetch_values(article, "url_helpers.show_article_path(y.id)")
  end

end
