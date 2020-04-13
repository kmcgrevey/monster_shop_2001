class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.enabled?
      merchant.update(status: 0)
      flash[:success] = "Merchant account has been disabled."
    else
      merchant.update(status: 1)
      flash[:success] = "Merchant account has been enabled."
    end
    redirect_to "/admin/merchants"
  end
end
