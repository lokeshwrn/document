class HomeController < ApplicationController

  def dashboard
    @page_properties.merge!({:header => "Dashboard"})
  end

  def get_favs
    sleep(2)
    a={"#categories " => Category.get_favourites, "#sub-categories " => SubCategory.get_favourites, "#tags " => Tag.get_favourites, "#articles " => Article.get_favourites}.to_json
    render json: a, :layout => false
  end

  def get_toppers
    sleep(2)
    a={"#categories " => Category.get_toppers, "#sub-categories " => SubCategory.get_toppers, "#tags " => Tag.get_toppers, "#articles " => Article.get_toppers}.to_json
    render json: a, :layout => false
  end

  def get_search
    sleep(3)
    value=params[:search_data]
    a={"#categories " => Category.get_search(value), "#sub-categories " => SubCategory.get_search(value), "#tags " => Tag.get_search(value), "#articles " => Article.get_search(value)}.to_json
    render json: a, :layout => false
  end

  def make_favourite
    obj=params[:type].constantize.find(params[:id])
    if obj.update_column('favourite', !obj.favourite)
      render :json => {status: true}.to_json
    else
      render :json => {status: false}.to_json
    end
  end

  def make_rating
    obj=Article.find(params[:id])
    if obj.update_column('rating', params[:rating])
      render :json => {status: true}.to_json
    else
      render :json => {status: false}.to_json
    end
  end

  def tiny_url
    @article = Article.where(id: params[:id]).last
    if @article
      redirect_to show_article_path(@article.id)
    else
      redirect_to root_url
    end
  end

end
