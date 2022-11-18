class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_user.subject
  #
  def welcome_user
    @user = params[:user]
    @greeting = 'Hi'

    mail to: @user.email, subject: 'Welcome to Nursebook!'
  end
end
