class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      render 'new'
      flash.now[:alert] = "Incorrect name and password combination"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
