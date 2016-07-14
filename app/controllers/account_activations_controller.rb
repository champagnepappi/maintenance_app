class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])#authenticate user corresponding to email address in params hash
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.activate
      log_in_user
      flash[:success] = "Account activated"
      redirect_to user
    else
      flash[:alert] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
