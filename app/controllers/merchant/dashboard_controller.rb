class Merchant::DashboardController < Merchant::BaseController
  before_action :require_merchant

<<<<<<< HEAD
  # def index
  #   binding.pry
  #   @merchant = Merchant.find(current_user.merchant_id.to_s)
  # end

  def show
=======
  def show
    #@user = current_user
>>>>>>> fadd900b229fd62eed0283cecebfad01824da738
    @merchant = Merchant.find(current_user.merchant_id)
  end

end
