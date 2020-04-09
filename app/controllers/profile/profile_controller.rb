class Profile::ProfileController < Profile::BaseController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to ("/profile")
      flash[:success] = "Your information has been updated!"
    else
      redirect_to ("/profile/#{user.id}/edit")
      flash[:error] = user.errors.full_messages.to_sentence
    end
  end
  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end
end
