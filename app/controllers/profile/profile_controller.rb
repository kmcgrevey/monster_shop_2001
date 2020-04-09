class Profile::ProfileController < Profile::BaseController
  def show
    @user = current_user
  end

  def edit
    @user = current_user

  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to ("/profile")
    flash[:success] = "Your information has been updated!"
  end
  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end
end
