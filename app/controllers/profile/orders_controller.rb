class Profile::OrdersController < Profile::BaseController

  def index
    @user = current_user
  end

end
