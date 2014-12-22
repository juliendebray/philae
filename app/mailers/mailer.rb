class Mailer < ActionMailer::Base
  #default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.contact_us.subject
  #
  def contact_us(name, user_email, message)
    @name = name
    @message = message

    mail to: ["florian.joulie@explorizers.com", "julien.debray@explorizers.com"],
          subject: " #{name} / contact sur explorizers.com", from: user_email
  end
end
