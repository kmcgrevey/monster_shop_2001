class Merchant::DashboardController < Merchant::BaseController
  before_action :require_merchant

  def show
    @merchant = Merchant.find(current_user.merchant_id)
  end

end
