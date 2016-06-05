class ArticlesController < ApplicationController

  def new
    @page_properties.merge({:header => "New Article"})
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.new
  end

  def edit
    @page_properties.merge({:header => "Edit Article"})
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.find(params[:id])
  end

  def index
    @page_properties.merge({:header => "Article"})
    @sub_category = SubCategory.find(params[:sub_category_id])
    @articles = @sub_category.articles.all.order(rating: :desc)
  end

  def show
    @page_properties.merge({:header => "Article"})
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path(@article.sub_category.id)
    else
      render 'new'
    end
  end

  def update
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path(@article.sub_category.id)
    else
      render 'edit'
    end
  end

  def destroy
    @sub_category = SubCategory.find(params[:sub_category_id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :content, :status, :reference_url, :github_url, :rating, :sub_category_id)
  end

end
