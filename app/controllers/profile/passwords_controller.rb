class Profile::PasswordsController < Profile::BaseController

  def edit
  end

  def update
    user = User.find(session[:user_id])
    if user.update(new_password)
      flash[:succes] = "Your password has been updated!"
      redirect_to "/profile"
    else
      flash[:error] = "Password and password confirmation must match."
      redirect_back(fallback_location: "/")
    end
  end

  private

  def new_password
    params.permit(:password, :password_confirmation)
  end
end
