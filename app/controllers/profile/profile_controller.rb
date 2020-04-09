class Profile::ProfileController < Profile::BaseController
  def show
    @user = User.find(session[:user_id])
  end

end
