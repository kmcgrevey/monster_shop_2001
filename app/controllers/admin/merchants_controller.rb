class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end
end
