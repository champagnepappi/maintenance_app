class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @requests = Request.requested
    @approved = Request.approved
    @rejected = Request.rejected
  end
  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      flash[:success] = "Maintenance Request created!" 
      redirect_to root_url
    else
      @feed_items = [] #supress feed for failed submissions
      render 'static_pages/home'
    end
  end
  def show
    @request = Request.find(params[:id])
    @comments = @request.comments
  end

  def request
    mrequest = Request.find(params[:id])
    mrequest.update_attribute(:status, params[:status])

  end

  def destroy
    @request.destroy
    flash[:success] = "Maintenance Request deleted"
    redirect_to request.referrer || root_url
    #arrange to redirect to page issuing the delete request
  end

  private
  def request_params
    params.require(:request).permit(:content, :picture)
  end

  def correct_user
    @request = current_user.requests.find_by(id: params[:id])
    redirect_to root_url if @request.nil?
  end
end
