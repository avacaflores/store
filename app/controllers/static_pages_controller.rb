class StaticPagesController < ApplicationController
  
  skip_before_action :authorize, only: [:home, :about]
  
  
  def home
    render :layout => 'intro'
  end
  
end
