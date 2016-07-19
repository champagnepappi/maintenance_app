class UsersController < ApplicationController
  before_action :logged_in_user, only:[:index,:edit,:update,:destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :dashboard]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # log_in @user
      # redirect_to @user
      # flash[:success] = "You successfully signed up"
      @user.send_activation_email
      flash[:info] = "Check your email to activate your account"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @requests = @user.requests
    @comments = @user.comments
  end

  def index
    @users = User.all
    # @users = User.paginate(page: params[:page])
  end

  def dashboard
    @maintainers = User.maintainer
    @admins = User.admin
    @users = User.user
  end

  def rolify
    user = User.find(params[:id])
    roles = params[:role]
    user.update_attribute(:role, roles)
    respond_to do |format|
      format.js {}
      format.html {
        redirect_to dashboard_path
      }
    end
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

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

  #confirm a logged in user
  # def logged_in_user
  #   unless logged_in?
  #     store_location
  #     flash[:alert] = "Please Login"
  #     redirect_to login_url
  #   end
  # end
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  
end
