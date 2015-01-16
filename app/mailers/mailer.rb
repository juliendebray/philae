class Mailer < ActionMailer::Base
  #default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.contact_us.subject
  #
  def contact_us(name, user_email, message, current_user)
    @name = name
    @message = message
    @user = current_user

    mail to: ["dora@explorizers.com"],
          subject: " #{name} / contact sur explorizers.com", from: user_email
  end
end
