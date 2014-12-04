class ContactSharesController < ApplicationController

  # def index
  #   render json: ContactShare.all
  # end

  def create
    @contact_share = ContactShare.new(contact_share_params)
    if @contact_share.save

      shared_contact = Contact.find_by_id(contact_share_params[:contact_id])
      new_name = shared_contact.name
      new_email = shared_contact.email
      new_user_id = contact_share_params[:user_id]

      Contact.create!(name: new_name, email: new_email, user_id: new_user_id)

      render json: @contact_share
    else
      render(
      json: @contact_share.errors.full_messages, status: :unprocessable_entity
      )
    end
  end


  # def show
  #   @contact_share = ContactShare.find(params[:id])
  #   render json: @contact_share
  # end

  def destroy
    @destroyed = ContactShare.destroy(params[:id])
    render json: @destroyed

  end

  # def update
  #   @updated_record = ContactShare.find_by_id(params[:id])
  #
  #
  #
  #   if @updated_record.update(contact_share_params)
  #     render json: @updated_record
  #   else
  #     render(
  #     json: @updated_record.errors.full_messages, status: :unprocessable_entity
  #     )
  #   end
  # end


  private

  def contact_share_params
    params.require(:contact_share).permit(:user_id, :contact_id)
  end
end
