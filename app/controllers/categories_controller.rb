class CategoriesController < ApplicationController

  def index
    @page_properties={:header => "Categories"}
    @category = Category.where(:status => true)
  end

  def show
    @category = Category.find_by_id(params[:id])
    @page_properties={:header => @category.try(:name).to_s.upcase}
    @sub_category = @category.sub_categories.where(:status=>true)
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
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :status, :favourite)
  end

end
