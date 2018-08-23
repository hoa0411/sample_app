class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.user.checked_remember ? remember(user) : forget(user)
      redirect_to user
    else
<<<<<<< 2fbe0f15c0cae6b5e5234426d260d4f498922ea4
      flash.now[:danger] = t "static_pages.invalid"
      render :new
=======
    flash.now[:danger] = t("static_pages.invalid")
    render :new
>>>>>>> reset d5cf4dc
    end
  end

  def destroy
<<<<<<< 2fbe0f15c0cae6b5e5234426d260d4f498922ea4
    log_out if logged_in?
=======
    log_out
>>>>>>> reset d5cf4dc
    redirect_to root_path
  end
end
