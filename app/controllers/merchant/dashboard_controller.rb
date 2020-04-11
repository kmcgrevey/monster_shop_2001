class Merchant::DashboardController < Merchant::BaseController
  before_action :require_merchant

  def index
  end

  def show
    @user = current_user
    @merchant = Merchant.find(@user.merchant_id)
  end

end
