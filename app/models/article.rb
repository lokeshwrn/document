class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :sub_category
  has_many :comments
  has_many :tags

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :by_favs, -> {where('favourite = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }
  scope :top_rated, -> { order("rating desc") }

  def self.fetch_values(articles)
    hash={}
    articles.each_with_index do |value, index|
      k=index;y=value
      k=ALPHA_NUMERIC_MAPPING[(k+1).to_s]
      hash[k]={}
      hash[k]["title"]=y.title
      hash[k]["url"]=y.id.to_s
      hash[k]["desc"]=y.description
      hash[k]["count"]=y.rating
    end
    hash
  end

  def self.get_favourites
    fetch_values(Article.by_favs.first(6))
  end

  def self.get_toppers
    fetch_values(Article.top_rated.first(6))
  end

  def self.get_search(value)
    article=Article.where("title LIKE ? or description LIKE ? OR content LIKE ?", "%#{value}%", "%#{value}%", "%#{value}%").uniq
    fetch_values(article)
  end

end
