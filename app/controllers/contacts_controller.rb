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
    render :new if @contact.invalid?
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
    redirect_to root_path, notice: 'お問い合わせありがとうございました！！'
  end

  def receive
    @contacts = Contact.all
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
