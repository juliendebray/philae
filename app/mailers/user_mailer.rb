class UserMailer < ActionMailer::Base
  default from: 'crew@woohoo.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user  # Instance variable => available in view
    @greeting = "Hi"

    mail(to: @user.email, subject: 'Welcome to Woohoo')
    # This will render a view in `app/views/user_mailer`!
  end

  def share_trip(user, trip)
    @user = user
    @trip = trip
    mail(to: @user.email, subject: 'Share my trip')
  end
end
