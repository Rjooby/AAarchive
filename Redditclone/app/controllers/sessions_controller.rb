class SessionsController < ApplicationController


  def create
    @user = User.find_by_credentials(params[:session][:name],params[:session][:password])
    log_in!(@user)
    render text: "logged in"
  end

  def destroy
    log_out!
    render :new
  end
end
