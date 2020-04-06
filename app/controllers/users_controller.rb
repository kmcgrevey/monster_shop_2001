class UsersController < ApplicationController
  def new

  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success]= "You are now registered and logged in!"
      redirect_to "/profile"
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
