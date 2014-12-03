class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end

  end



  def show
    @user = User.find(params[:id])
    render json: params
  end

  def destroy

    @destroyed = User.destroy(params[:id])
    render json: @destroyed

  end

  def update
    @updated = User.update(params[:id], user_params)
    render json: @updated
  end




private

  def user_params
    params.require(:user).permit(:username)
  end
end
