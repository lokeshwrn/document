class HomeController < ApplicationController

  def dashboard
    @page_properties={:header => "Category"}
    @category = Category.where(:status => true)
    @sub_category = SubCategory.where(:status => true)
    @articles = Article.where(:status => true)
  end

end
