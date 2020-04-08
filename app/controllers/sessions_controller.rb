class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are logged in!"
      if user.default?
        redirect_to "/default/profile"
      elsif user.merchant?
        redirect_to "/merchant"
      end
    else
      flash[:error] = "Sorry sucka"
    end
  end
end
