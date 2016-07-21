class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new

  end
  def show
    @request = Request.find_by(id: params[:id])
    @comments = @request.comments
  end
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment added"
      redirect_to Request.find(@comment.request_id)
    else
      render 'new'
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :request_id)
  end
end
