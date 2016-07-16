class StaticPagesController < ApplicationController
  def home
    @request = current_user.requests.build if logged_in?
  end

  def about
  end

  def help
  end
end
