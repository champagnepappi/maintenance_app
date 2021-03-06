class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new

  end
  def show
    @request = Request.find_by(id: params[:id])
  end
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment added"
      redirect_to Request.find(@comment.request_id)
       @user = User.find(@comment.request_id)
       @user.send_comment_email
    else
      flash[:danger] = ""
      render 'show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer || root_url
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :request_id)
  end
end
