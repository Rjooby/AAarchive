class SubsController < ApplicationController
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      render :show
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      render :show
    else
      flash[:errors] = @sub.errors.full_messages
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end



  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
