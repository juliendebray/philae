class ContactsController < ApplicationController

  def new
  end

  def create
    email = params[:email]
    name = params[:name]
    message = params[:message]

    #send mail
    Mailer.contact_us(name, email, message, current_user).deliver

    redirect_to root_path
    # @contact = Contact.new(params[:contact])
    # @contact.request = request
    # if @contact.deliver
    #   flash.now[:error] = nil
    #   flash.now[:notice] = 'Thank you for your message!'
    # else
    #   flash.now[:error] = 'Cannot send message.'
    #   render :new
    end
end
