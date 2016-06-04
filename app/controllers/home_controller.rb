class HomeController < ApplicationController

  def dashboard
    @page_properties={:header => "Dashboard"}
    @sub_category = SubCategory.by_active.top_by_count.first(6)
    @articles = Article.by_active.top_rated.first(6)
  end

  def get_favs
    sleep(2)
    a={"#categories " => Category.get_favourites, "#sub-categories " => SubCategory.get_favourites, "#articles " => Article.get_favourites, "#tags" => Tag.get_favourites}.to_json
    render json: a, :layout => false
  end

  def get_toppers
    sleep(2)
    a={"#categories " => Category.get_toppers, "#sub-categories " => SubCategory.get_toppers, "#articles " => Article.get_toppers, "#tags" => Tag.get_toppers}.to_json
    render json: a, :layout => false
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
