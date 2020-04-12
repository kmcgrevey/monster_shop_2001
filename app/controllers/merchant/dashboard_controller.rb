class Merchant::DashboardController < Merchant::BaseController
  before_action :require_merchant

  # def index
  #   binding.pry
  #   @merchant = Merchant.find(current_user.merchant_id.to_s)
  # end

  def show
    @merchant = Merchant.find(current_user.merchant_id)
  end

end
