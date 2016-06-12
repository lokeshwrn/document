class CategoriesController < ApplicationController

  def index
    @page_properties={:header => "Category"}
    @category = Category.where(:status => true)
  end

  def show
    @page_properties={:header => "Category"}
    @category = Category.find_by_id(params[:id])
    @sub_category = @category.sub_categories.where(:status=>true)
    render :controller => 'sub_categories', :action => 'index'
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

  def save
    flag=false
    if params[:commit] == "Create"
      @category = Category.new(category_params)
      flag=@category.save
    elsif params[:commit] == "Update"
      @category = Category.find(params[:id])
      flag=@category.update(category_params)
    end
    flag ? (redirect_to categories_path) : (render 'new')
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
    params.require(:category).permit(:name, :description, :status)
  end

end
