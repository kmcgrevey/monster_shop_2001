class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
require "pry"; binding.pry
  end

end
