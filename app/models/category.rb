class Category < ActiveRecord::Base

  has_many :sub_categories

  validates :name, presence: true
  validates :description, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :by_favs, -> {where('favourite = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }

  def self.fetch_values(categories)
    hash={}
    categories.each_with_index do |value, index|
      k=index;y=value
      k=ALPHA_NUMERIC_MAPPING[(k+1).to_s]
      hash[k]={}
      hash[k]["title"]=y.name
      hash[k]["url"]="/categories/#{y.id.to_s}/sub-categories"
      hash[k]["desc"]=y.description
      hash[k]["count"]=y.sub_categories.count
    end
    hash
  end

  def self.top_by_count
    self.all.sort{|x,y| y.sub_categories.count <=> x.sub_categories.count}
  end

  def self.get_favourites
    fetch_values(Category.by_favs.first(6))
  end

  def self.get_toppers
    fetch_values(Category.top_by_count.first(6))
  end

  def self.get_search(value)
    categories=Category.where("name LIKE ? OR description LIKE ?", "%#{value}%", "%#{value}%").uniq
    fetch_values(categories)
  end

end
