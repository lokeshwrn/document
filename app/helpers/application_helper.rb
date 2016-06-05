module ApplicationHelper

  # class << self
  #   include Rails.application.routes.url_helpers
  # end
  delegate :url_helpers, to: 'Rails.application.routes'

  def fetch_values(data, helper)
    hash={}
    data.each_with_index do |value, index|
      k=index;y=value
      k=ALPHA_NUMERIC_MAPPING[(k+1).to_s]
      hash[k]={}
      hash[k]["title"]=y.name rescue y.title
      hash[k]["url"]=eval(helper)
      hash[k]["desc"]=y.description
      hash[k]["count"]=y.sub_categories.count rescue y.articles.count rescue y.rating
    end
    hash
  end

  def custom_button_1(name, link)
    content_tag :a, href: link, class: "button" do
      content_tag :span, name
    end
  end

end
