class SessionsController < ApplicationController
  before_action :is_logged_in, except: :destroy

  def new
  end
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user #redirect requested url if it exists
      else
        message = "Account not activated"
        message += "Check your email for activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      render 'new'
      flash.now[:alert] = "Incorrect name and password combination"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def is_logged_in
    if current_user
      redirect_to root_url 
      flash[:message] = "You are already logged in"
    end
  end
end
