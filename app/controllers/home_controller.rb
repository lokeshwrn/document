class HomeController < ApplicationController

  def dashboard
    @page_properties={:header => "Dashboard"}
    @category = Category.by_active.top_by_count.last(3)
    @sub_category = SubCategory.by_active.top_by_count.last(3)
    @articles = Article.by_active.top_rated.limit(3)
  end

  def tiny_url
    @article = Article.where(id: params[:id]).last
    if @article
      redirect_to "/sub-categories/#{@article.sub_category.id}/articles/#{@article.id}"
    else
      redirect_to root_url
    end
  end

end
