class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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

  def show
    @posts = @user.posts
    @post = Post.new(user: @user)
  end

  def update

    if @user.update(user_params)
      redirect_to home_path, notice: 'You have successfully edited your profile!'
    else
      render 'edit', notice: 'You have filled in the registration fields incorrectly!'
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to home_path, notice: 'You have successfully deleted your profile!'
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
  end

 def set_user
    @user = User.find(params[:id])
  end
end
