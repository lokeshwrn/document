class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, :except => [:get_search]

  before_filter :default_properties

  def default_properties
    @page_properties={:page_title => "Document"}
    @categories = Category.by_active.first(5)
  end

end
