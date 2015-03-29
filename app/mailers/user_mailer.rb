class UserMailer < ApplicationMailer
  # Subjects can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #   en.user_mailer.welcome.subject
  #
  def confirm(user)
    @user = user
    mail to: user.email, from: ENV['FROM_EMAIL']
  end
  def welcome(user)
    @user = user
    mail to: user.email, from: ENV['FROM_EMAIL']
  end
end
