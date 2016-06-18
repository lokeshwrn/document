class TagsController < ApplicationController

  def index
    @page_properties={:header => "Tags"}
    @tag = Tag.all #.where(:status => true)
  end

  def show
    @tag = Tag.find_by_id(params[:id])
    @page_properties={:header => @tag.try(:name).to_s.upcase}
  end

  def new
    @page_properties={:header => "New Tag"}
    @tag = Tag.new
  end

  def edit
    @page_properties={:header => "Edit Tag"}
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :alias_name, :status, :favourite)
  end
  
end
