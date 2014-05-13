class SessionsController < ApplicationController
  
  skip_before_action :authorize
  
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to products_url, notice: t('.message.login', user: user.name ) 
    else
      redirect_to login_url, flash: { danger: t('.message.invalid') }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to products_url, flash: { info: t('.message') }
  end
end
