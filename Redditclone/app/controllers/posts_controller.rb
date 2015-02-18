class PostsController < ApplicationController
  before_action :ensure_correct_author, only: [:edit, :update]

  def new
    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    # @post.post_subs = params[:sub_ids]
    # fail
    if @post.save
      render :show
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  # def edit
  #
  #   render :edit
  # end

  def update

    if @post.update(post_params)
      render :show
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  def show
    @post = Post.find(params[:id])
    @comment_hash = @post.comments_by_parent_id
  end

  def ensure_correct_author
    @post = Post.find(params[:id])
    redirect_to subs_url unless @post.author_id == current_user.id
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end


end
