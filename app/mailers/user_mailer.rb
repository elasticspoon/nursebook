class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_user.subject
  #
  def welcome_user
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
