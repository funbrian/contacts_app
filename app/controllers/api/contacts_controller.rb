class Api::ContactsController < ApplicationController
  def index 
    if current_user
      @contacts = current_user.contacts
    else
      @contacts = []
    end
    render 'index.json.jb'
  end

  def show
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    render 'show.json.jb'
  end
  
  def create
    @coordinates = Geocoder.coordinates("#{params[:input_address]}")
    @contact = Contact.new(
      first_name: params[:input_first_name],
      middle_name: params[:input_middle_name],
      last_name: params[:input_last_name],
      email: params[:input_email],
      phone_number: params[:input_phone_number],
      address: params[:input_address],
      latitude: @coordinates[0],
      longitude: @coordinates[1],
      bio: params[:input_bio],
      user_id: current_user.id
    )
    if @contact.save
      render 'show.json.jb'
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    coordinates = Geocoder.coordinates("#{params[:input_address] || @contact.address}")
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    @contact.first_name = params[:input_first_name] || @contact.first_name
    @contact.middle_name = params[:input_middle_name] || @contact.middle_name
    @contact.last_name = params[:input_last_name] || @contact.last_name
    @contact.email = params[:input_email] || @contact.email
    @contact.phone_number = params[:input_phone_number] || @contact.phone_number
    @contact.address = params[:input_address] || @contact.address
    @contact.latitude = coordinates[0]
    @contact.longitude = coordinates[1]
    @contact.bio = params[:input_bio] || @contact.bio
    if @contact.save
      render 'show.json.jb'
    else 
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    @contact.destroy
    render 'destroy.json.jb'
  end
end
