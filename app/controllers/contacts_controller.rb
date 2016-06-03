class ContactsController < ApplicationController
  def new
    if params[:back]
      @contact = Contact.new(contact_params)
    else
      @contact = Contact.new
    end
  end

  def confirm
    @contact = Contact.new(contact_params)
    redirect_to contacts_new_path if @contact.invalid?
  end

  def create
    @contact = Contact.new(contact_params)
    render :create if @contact.save
    render :new if params[:back]
  end

  def receive
    @contacts = Contact.all
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
