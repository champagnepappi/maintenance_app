class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @comment = Comment.new
  end
  
  def create
    user = User.find_by(id: params[:id])
    # @comment = current_user.comments.build(comment_params)
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment added"
      redirect_to user
    else
      render 'comments/new'
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
