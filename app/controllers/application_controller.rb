class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :load_sections
  before_action :authorize
  
  def load_sections
    @sections = Section.all.order(:name)
    @brands = Brand.all.order(:name)
  end
  
  protected
  
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, flash: { warning: "Please log in" } 
    end
  end
  
end
