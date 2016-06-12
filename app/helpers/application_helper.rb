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

  def strip_html_tags(content)
    content = content.gsub("</p>", "</p> ").gsub("<br />", "<br /> ").strip
    decoder = HTMLEntities.new
    decoder.decode(Sanitize.clean(content))
  end

  def auto_complete_tag(name:, data:, selected:, hintText:"Enter Search Terms", searchingText:"Querying", noResultsText:"Nothing found" )
    collection=data.collect{|x| {id: x.id, name: x.name}.to_json}
    selection=selected.collect{|x| {id: x.id, name: x.name}.to_json}

    "
    <input type='text' id='demo-indput-local' name=#{name} />
    <script>
$(document).ready(function(){
    $('#demo-indput-local').tokenInput(#{collection},
        {
            prePopulate: #{selection},
            preventDuplicates: true,
            hintText: '#{hintText}',
            searchingText: '#{searchingText}',
            noResultsText: '#{noResultsText}',
            searchDelay: 1000,

    });
});
</script> "
  end

end
