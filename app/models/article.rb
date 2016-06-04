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

  def self.get_favourites
    fetch_values(Article.by_favs.first(6))
  end

  def self.get_toppers
    fetch_values(Article.by_favs.first(6))
  end

  def self.fetch_values(articles)
    hash={}
    articles.each_with_index do |value, index|
      k=index;y=value
      k=ALPHA_NUMERIC_MAPPING[(k+1).to_s]
      hash[k]={}
      hash[k]["title"]=y.title
      hash[k]["url"]="/categories/#{y.id.to_s}/sub-categories"
      hash[k]["desc"]=y.description
      hash[k]["count"]=1 # needs to be changed
    end
    hash
  end

end
