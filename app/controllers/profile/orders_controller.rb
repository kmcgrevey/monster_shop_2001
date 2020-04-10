class Profile::OrdersController < Profile::BaseController

  def show
    @user = current_user
  end

end
