class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are logged in!"
      redirect_to "/default/profile"
    else
      flash[:error] = "Sorry sucka"
    end
  end
end
