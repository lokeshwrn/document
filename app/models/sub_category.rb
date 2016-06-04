class SubCategory < ActiveRecord::Base

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
    fetch_values(SubCategory.by_favs.first(6))
  end

  def self.get_toppers
    fetch_values(SubCategory.top_by_count.first(6))
  end

  def self.fetch_values(sub_cat)
    hash={}
    sub_cat.each_with_index do |value, index|
      k=index;y=value
      k=ALPHA_NUMERIC_MAPPING[(k+1).to_s]
      hash[k]={}
      hash[k]["title"]=y.name
      hash[k]["url"]="/sub-categories/#{y.id.to_s}/articles"
      hash[k]["desc"]=y.description
      hash[k]["count"]=y.articles.count
    end
    hash
  end
end
