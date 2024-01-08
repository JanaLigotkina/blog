class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to home_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Wrong email or password!'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to home_path, notice: 'Logged out successfully!'
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
