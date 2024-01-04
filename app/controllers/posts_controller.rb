class PostsController < ApplicationController
  def index
    # @posts = Post.all
  end

  def new
    # @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.save

    redirect_to @post
  end

  def show
    @post = Post.find(params[:id])

    if @post.nil?
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :body)
  end
end
