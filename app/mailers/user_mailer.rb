class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("static_pages.account_activated")
  end

  def password_reset
    @greeting = t "static_pages.hi"

    mail to: t("static_pages.mail_example")
  end
end
