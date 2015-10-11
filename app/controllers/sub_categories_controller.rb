class SubCategoriesController < ApplicationController

  def index
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.all
  end

  def new
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.new
  end

  def edit
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.find(params[:id])
  end

  def create
    debugger
    @category = Category.find(params[:sub_category][:category_id])
    @sub_category = @category.sub_categories.new(sub_category_params)
    if @sub_category.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.find(params[:id])
    if @sub_category.update(sub_category_params)
      redirect_to @sub_category
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.find(params[:id])
  end

  def destroy

  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:name, :description, :status, :category_id)
  end
end
