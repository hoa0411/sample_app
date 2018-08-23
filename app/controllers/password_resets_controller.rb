class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration, only: [:edit, :update]
  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "static_pages.sent_email"
      redirect_to root_url
    else
      flash.now[:danger] = t "static_pages.not_found_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("static_pages.can_not_empty"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t "static_pages.password_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Before filters

  def find_user
    @user = User.find_by(email: params[:email])
    return if @user.present?
    render html: t("static_pages.empty")
  end

  # Confirms a valid user.
  def valid_user
    unless @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "static_pages.password_reset_expired"
      redirect_to new_password_reset_url
    end
  end
end
