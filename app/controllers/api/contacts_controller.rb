class Api::ContactsController < ApplicationController
  def index 
    @contacts = Contact.all 
    render 'index.json.jb'
  end

  def show
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    render 'show.json.jb'
  end

  def create
    @contact = Contact.new(
      first_name: params[:input_first_name],
      email: params[:input_email],
      phone_number: params[:input_phone_number],
    )
    @contact.save
    render 'show.json.jb'
  end

  def update
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    @contact.first_name = params[:input_first_name] || @contact.first_name
    @contact.email = params[:input_email] || @contact.email
    @contact.phone_number = params[:input_phone_number] || @contact.phone_number
    @contact.save
    render 'show.json.jb'
  end

  def destroy
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    @contact.destroy
    render 'destroy.json.jb'
  end
end
