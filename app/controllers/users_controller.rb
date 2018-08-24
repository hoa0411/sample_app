class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :upadte]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

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
      flash[:success] = t "static_pages.home_page.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
       if @user.update_attributes(user_params)
      flash[:success] = t "static_pages.profile_page.profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "static_pages.please"
    redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
