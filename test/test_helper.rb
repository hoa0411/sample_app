ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  fixtures :all

  def is_logged_in?
    session[:user_id].present?
  end
<<<<<<< 2fbe0f15c0cae6b5e5234426d260d4f498922ea4

  def log_in_as user
    session[:user_id] = user.id
  end

  class ActionDispatch::IntegrationTest
    def log_in_as user, password: "password", remember_me: "1"
      post login_path, params: {session: {email: user.email,
        password: password, remember_me: remember_me}}
    end
  end
=======
>>>>>>> reset d5cf4dc
end
