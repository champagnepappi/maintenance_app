class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @request = current_user.requests.build 
      @feed_items = current_user.feed
      @comment = current_user.comments.build
    end
  end

  def about
  end

  def help
  end
end
