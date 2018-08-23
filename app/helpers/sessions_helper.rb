module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
<<<<<<< 2fbe0f15c0cae6b5e5234426d260d4f498922ea4
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
=======
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
>>>>>>> reset d5cf4dc
    end
  end

  def logged_in?
    current_user.present?
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
<<<<<<< 2fbe0f15c0cae6b5e5234426d260d4f498922ea4
    forget(current_user)
=======
>>>>>>> reset d5cf4dc
    session.delete(:user_id)
    @current_user = nil
  end
end
