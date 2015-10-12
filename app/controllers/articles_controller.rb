class ArticlesController < ApplicationController

  def new
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.new
    @page_properties={:header => "New Article"}
  end

  def edit
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.find(params[:id])
    @page_properties={:header => "Edit Article"}
  end

  def index
    @sub_category = SubCategory.find(params[:sub_category_id])
    @articles = @sub_category.articles.where(:status=>true).order(rating: :desc)
    @page_properties={:header => "Article"}
  end

  def show
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.find(params[:id])
    @page_properties={:header => "Article"}
  end

  def create
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.new(article_params)
    if @article.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @sub_category = SubCategory.find(params[:sub_category_id])
    @article = @sub_category.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @sub_category = SubCategory.find(params[:sub_category_id])

  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :content, :status, :reference_url, :github_url, :rating)
  end

end
