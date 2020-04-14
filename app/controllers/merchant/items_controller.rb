class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def update
    item = Item.find(params[:id])
    item.update(active?: !item.active?)
    flash[:success] = "'#{item.name}' has been marked inactive and is no longer for sale"
    redirect_to("/merchant/items")
  end

end
