class ContactsController < ApplicationController

  def index
    render json: User.find_by_id(params[:user_id]).contacts
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
      json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end

  end



  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def destroy
    @destroyed = Contact.destroy(params[:id])
    render json: @destroyed

  end

  def update
    p @updated_record = Contact.find_by_id(params[:id])
    puts params[:id]



    if @updated_record.update(contact_params)
      render json: @updated_record
    else
      render(
      json: @updated_record.errors.full_messages, status: :unprocessable_entity
      )
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
