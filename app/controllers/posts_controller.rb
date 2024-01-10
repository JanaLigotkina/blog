class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
    user_ids = @posts.pluck(:user_id).uniq
    @users_with_posts = User.where(id: user_ids)
  end

  def new
    @post = Post.new(user: current_user)
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to @post
    else
      flash.now[:alert] = 'Only registered users can add posts!'
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post was successfully updated.'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    redirect_to posts_path if @post.nil?
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post was successfully deleted.'
      redirect_to posts_path
    else
      render 'show'
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
