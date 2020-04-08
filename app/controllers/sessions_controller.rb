class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user == nil
      flash[:error] = "The credentials you entered are incorrect"
      redirect_to "/login"
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are logged in!"
      if user.default?
        redirect_to "/default/profile"
      elsif user.merchant?
        redirect_to "/merchant"
      end
    else
      flash[:error] = "The credentials you entered are incorrect"
      redirect_to "/login"
    end
  end
end
