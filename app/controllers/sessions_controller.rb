class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged In!"
      redirect_to users_path
    else
      flash.now[:alert] = "Email or password is invalid."
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out! Bye!"
    redirect_to root_url
  end
end