class Merchant::DashboardController < Merchant::BaseController
  before_action :require_merchant

  def index
    # @merchant = 
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

end
