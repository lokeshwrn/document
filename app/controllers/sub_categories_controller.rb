class SubCategoriesController < ApplicationController

  def index
    @page_properties={:header => "Sub Category"}
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.where(:status=>true)
  end

  def new
    @page_properties={:header => "New Sub Category"}
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.new
  end

  def edit
    @page_properties={:header => "Edit Sub Category"}
    @sub_category = SubCategory.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.new(sub_category_params)
    if @sub_category.save
      redirect_to sub_categories_path(@category.id)
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.find(params[:id])
    if @sub_category.update(sub_category_params)
      redirect_to sub_categories_path(@category.id)
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:name, :description, :status, :category_id)
  end
  
end
