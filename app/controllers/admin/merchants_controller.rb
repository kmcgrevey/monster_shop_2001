class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update!(status: "disabled")
    merchant.save!
    merchant.items.update(active?: false)
    flash[:success] = "Merchant account has been disabled."
    redirect_to "/admin/merchants"
  end
end
