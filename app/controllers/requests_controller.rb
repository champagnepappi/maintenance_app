class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @request = current_user.microposts.build(request_params)
    if @request.save
      flash[:success] = "Maintenance Request created!" 
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private
  def request_params
    params.require(:request).permit(:content)
  end
end
