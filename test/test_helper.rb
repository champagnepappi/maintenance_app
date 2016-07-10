ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  #make the helper method(logged_in) available
  #in test but with different name(is_logged_in)
  #to prevent being mistaken from each other
  def is_logged_in?
    !session[:user_id].nil?
  end
end
