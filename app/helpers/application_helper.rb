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

  # anchor button
  def custom_button_1(name="button", link="javascript(void)", align=nil)
    content_tag :a, href: link, class: "#{align} button".strip do
      content_tag :span, name
    end
  end

  def custom_button_2(name="button", link="javascript(void)", align=nil)
    content_tag :a, href: link, class: "#{align} button-1".strip do
      content_tag :span, name
    end
  end

  # Submit tag
  def custom_submit_1(name="submit", class_name=nil, align=nil)
    submit_tag(name, class: "#{class_name} #{align} button".strip)
  end

  def direct_link_menu(name, link, symbol)
    content_tag :li do
      content_tag :a, href: link do
        content_tag(:i, nil, class: "fa #{symbol}".strip) + content_tag(:span, name)
      end
    end
    #<li><a href="/"><i class="fa fa-home"></i>Home</a></li>
  end

  def parent_with_submenu(name, symbol, options)
    x=content_tag :a, href: "#", class: "sub-menu-toggle" do
      content_tag(:i, nil, class: "fa #{symbol}".strip) + content_tag(:span, name)
    end

    y=content_tag :ul, nil, class: "second-level-menu" do
      options.each do |value, link|
        concat content_tag(:li, content_tag(:a, value, href: link))
      end
    end

    content_tag :li do
      x+y
    end

    # <li>
    # <a href="#" class="sub-menu-toggle">
    #   <i class="fa fa-home"></i>
    #   <span>Categories</span>
    # </a>
    # <ul class="second-level-menu">
    #   <li><a href="#">New Sub Category</a></li>
    #   <li><a href="#">List Sub Category</a></li>
    # </ul>
    #</li>
  end

  # custom_check_box_1("category[status]", true, @category.status, "category_status")
  def custom_check_box_1(name, true_val, value, label)
    custom_check_box_main(name, true_val, value, label, "toggle-round")
  end

  # custom_check_box_2("category[status]", true, @category.status, "category_status")
  def custom_check_box_2(name, true_val, value, label)
    custom_check_box_main(name, true_val, value, label, "toggle-round-flat")
  end

  # custom_check_box_3("category[status]", true, @category.status, "category_status", "YES", "NO")
  def custom_check_box_3(name, true_val, value, label, on_val=nil, off_val=nil)
    custom_check_box_main(name, true_val, value, label, "toggle-yes-no", on_val, off_val)
  end

  def custom_check_box_main(name, true_val, value, label, class_name, data_on=nil, data_off=nil)
    check=check_box_tag name, true_val, value, class: "toggle #{class_name}".strip
    content=content_tag :label, nil, for: label, "data-off" => data_off, "data-on" => data_on
    false_selector=hidden_field_tag(name, !true_val, id: nil)
    true_selector=content_tag :div, nil, class: "switch" do
      check + content
    end
    false_selector + true_selector

    # <input type="hidden" value="false" name="category[status]">
    # <div class="switch">
    #      <input id="status" class="toggle toggle-round" type="checkbox" name="category[status]" value="true" checked="false">
    #      <label for="status"></label>
    # </div>
  end

  def strip_html_tags(content)
    content = content.gsub("</p>", "</p> ").gsub("<br />", "<br /> ").strip
    decoder = HTMLEntities.new
    decoder.decode(Sanitize.clean(content))
  end

end
