class CategoriesController < ApplicationController

  def index
    @category = Category.where(:status => true)
    @page_properties={:header => "Category"}
  end

  def new
    @page_properties={:header => "New Category"}
    @category = Category.new
  end

  def edit
    @page_properties={:header => "Edit Category"}
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def show
    @page_properties={:header => "Category"}
    @category = Category.find(params[:id])
  end

  def destroy

  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :status)
  end

end
