class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
    else
      render 'new'
      flash.now[:alert] = "Incorrect name and password combination"
    end
  end
end
