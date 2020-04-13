class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.enabled?
      merchant.update(status: 0)
      merchant.items.update(active?: false)
      flash[:success] = "Merchant account has been disabled."
    else
      merchant.update(status: 1)
      merchant.items.update_all(active?: true)
      flash[:success] = "Merchant account has been enabled."
    end
    redirect_to "/admin/merchants"
  end
end
