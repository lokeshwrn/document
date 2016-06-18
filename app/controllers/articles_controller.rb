class ArticlesController < ApplicationController

  def new
    @page_properties.merge!({:header => "New Article"})
    @article = Article.new
  end

  def edit
    @page_properties.merge!({:header => "Edit Article"})
    @article = Article.find(params[:id])
  end

  def index
    @page_properties.merge!({:header => "Articles"})
    @articles = Article.all.order(rating: :desc)
  end

  def show
    @article = Article.find(params[:id])
    @page_properties.merge!({:header => @article.title})
  end

  def create
    article_params[:tag_ids] ||= params[:tag_ids]
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    article_params[:tag_ids] ||= params[:tag_ids]
    if @article.update(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @sub_category = SubCategory.find(params[:sub_category_id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :content, :status, :reference_url, :github_url, :rating, :sub_category_id, :tag_ids=>[])
  end

end
