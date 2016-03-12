class Category < ActiveRecord::Base

  has_many :sub_categories

  validates :name, presence: true
  validates :description, presence: true

  scope :by_active, -> {where('status = ?', true)}
  scope :latest_by_updated, -> { order("updated_at desc") }

  def self.top_by_count
    self.all.sort{|x,y| y.sub_categories.count <=> x.sub_categories.count}
  end

end
