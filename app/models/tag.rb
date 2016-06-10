class Tag < ActiveRecord::Base

  has_many :articles, through: :article_tags

  validates :name, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :by_favs, -> {where('favourite = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }

  def self.fetch_values(tags)
    hash={}
    tags.each_with_index do |value, index|
      k=index;y=value
      k=ALPHA_NUMERIC_MAPPING[(k+1).to_s]
      hash[k]={}
      hash[k]["title"]=y.name
      hash[k]["url"]="hello"
      hash[k]["desc"]=y.description
      hash[k]["count"]=y.articles.count
    end
    hash
  end

  def self.top_by_count
    self.all.sort{|x,y| y.articles.count <=> x.articles.count}
  end

  def self.get_favourites
    fetch_values(Tag.by_favs.first(6))
  end

  def self.get_toppers
    fetch_values(Tag.top_by_count.first(6))
  end

  def self.get_search(value)
    tag=Tag.where("name LIKE ?", "%#{value}%")
    fetch_values(tag)
  end

end
