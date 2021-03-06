class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user.present?
    render html: t("static_pages.empty")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t("static_pages.home_page.welcome")
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
