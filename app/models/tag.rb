class Tag < ActiveRecord::Base

  class << self
    include ApplicationHelper
  end

  has_and_belongs_to_many :articles

  validates :name, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :by_favs, -> {where('favourite = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }

  def self.top_by_count
    self.all.sort{|x,y| y.articles.count <=> x.articles.count}
  end

  def self.get_favourites
    fetch_values(Tag.by_favs.first(6), "url_helpers.show_tag_path(y.id)")
  end

  def self.get_toppers
    fetch_values(Tag.top_by_count.first(6), "url_helpers.show_tag_path(y.id)")
  end

  def self.get_search(value)
    tag=Tag.where("name LIKE ?", "%#{value}%")
    fetch_values(tag, "url_helpers.show_tag_path(y.id)")
  end

  def articles_count
    self.articles.count rescue 0
  end

end
