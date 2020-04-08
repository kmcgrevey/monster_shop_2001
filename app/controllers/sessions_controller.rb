class SessionsController < ApplicationController
  def new
    if !current_user.nil?
      if current_user.default?
        flash[:success] = "You are already logged in!"
        redirect_to "/default/profile"
      end
      if current_user.merchant?
        flash[:success] = "You are already logged in!"
        redirect_to "/merchant"
      end
      if current_user.admin?
        flash[:success] = "You are already logged in!"
        redirect_to "/admin"
      end
    end

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
      elsif user.admin?
        redirect_to "/admin"
      end    
    else
      flash[:error] = "The credentials you entered are incorrect"
      redirect_to "/login"
    end
  end
end
