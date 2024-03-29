ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  require "minitest/reporters"
  Minitest::Reporters.use!

  def is_logged_in?
    !session[:user_id].nil?
  end

  #単体テスト用
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

#統合テスト用
class ActionDispatch::IntegrationTest
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
