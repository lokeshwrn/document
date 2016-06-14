class SubCategoriesController < ApplicationController

  def index
    @page_properties={:header => "Sub Category"}
    @sub_category = SubCategory.where(:status=>true)
  end

  def show
    @sub_category = SubCategory.find_by_id(params[:id])
    @page_properties={:header => @sub_category.try(:name).to_s.upcase}
    @articles = @sub_category.articles.where(:status=>true)
  end

  def new
    @page_properties={:header => "New Sub Category"}
    @sub_category = SubCategory.new
  end

  def edit
    @page_properties={:header => "Edit Sub Category"}
    @sub_category = SubCategory.find(params[:id])
  end

  def create
    @sub_category = SubCategory.new(sub_category_params)
    if @sub_category.save
      redirect_to sub_categories_path
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
    params.require(:sub_category).permit(:id, :name, :description, :status, :category_id, :favourite)
  end

end
