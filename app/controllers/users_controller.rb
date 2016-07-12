class UsersController < ApplicationController
  before_action:logged_in_user, only: [:edit,:update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "You successfully signed up"

    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def index
    @users = User.all
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your Profile was successfully Updated!!!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

  #confirm a logged in user
  def logged_in_user
    unless logged_in?
      flash[:alert] = "Please Login"
      redirect_to login_url
    end
  end

  
end
