class UserMailer < ActionMailer::Base
  default from: 'dora@explorizers.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user  # Instance variable => available in view
    @greeting = "Hi"

    mail(to: @user.email, subject: 'Welcome to Explorizers')
    # This will render a view in `app/views/user_mailer`!
  end

  def share_trip(user, trip)
    @user = user
    @trip = trip
    mail(to: @user.email, subject: 'Share my trip')
  end

  def notif_trip(user, trip)
    @user = user
    @trip = trip
    if @trip.trip_comments && @trip.trip_comments.last.name.length > 0
      @guest_name = @trip.trip_comments.last.name || t('n_name')
      @nb_comments = @trip.trip_comments.where(name: @guest_name).count
    else
      @guest_name = t('n_name')
    end
    mail(to: @user.email, subject: "Notification trip: #{@guest_name} #{t('user_mailer_notif')}")
  end

  def send_trip_summary(user, trip)
    @user = user
    @trip = trip
    @trip_exp_tab = @trip.trip_experiences.sort_by do |te|
      te.order
    end
    mail(to: @user.email, subject: "Votre résumé de voyage")
  end
end
