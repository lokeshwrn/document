class Category < ActiveRecord::Base

  class << self
    include ApplicationHelper
  end

  has_many :sub_categories

  validates :name, presence: true
  validates :description, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :by_favs, -> {where('favourite = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }

  def self.top_by_count
    self.all.sort{|x,y| y.sub_categories.count <=> x.sub_categories.count}
  end

  def self.get_favourites
    fetch_values(Category.by_favs.first(6), "url_helpers.show_category_path(y.id)")
  end

  def self.get_toppers
    fetch_values(Category.top_by_count.first(6), "url_helpers.show_category_path(y.id)")
  end

  def self.get_search(value)
    categories=Category.where("name LIKE ? OR description LIKE ?", "%#{value}%", "%#{value}%").uniq
    fetch_values(categories, "url_helpers.show_category_path(y.id)")
  end

end
