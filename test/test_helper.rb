ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_with(user = nil)
    return if user.nil?
    if user.is_a?(Student)
      session[:sudent_id] = user.id
    else
      session[:professor_id] = user.id
    end
  end
end
