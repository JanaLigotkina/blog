class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: 'You have successfully registered!'
    else
      render 'new', notice: 'You have filled in the registration fields incorrectly!'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to home_path, notice: 'You have successfully edited your profile!'
    else
      render 'edit', notice: 'You have filled in the registration fields incorrectly!'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.delete(:user_id)

    redirect_to home_path, notice: 'You have successfully deleted your profile!'
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new(user: @user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
