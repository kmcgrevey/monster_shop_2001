class UsersController < ApplicationController
  def new

  end

  def create
    user = User.new(user_params)
    if User.save
      flash[success-flash]= "You are now registered and logged in!"
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
