class FrontEndController < ApplicationController
  
  def index
    @products = Product.all
  end
  
  
end
