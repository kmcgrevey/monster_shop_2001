class Merchant::OrdersController < Merchant::BaseController

  def show
    @merchant = Merchant.find(current_user.merchant_id)
    @order = Order.find(params[:order_id])
  end

  def update
    order = Order.find(params[:order_id])
    item = Item.find(params[:item_id])
    order.fulfill_item(item)
    redirect_to "/merchant/orders/#{order.id}"
    flash[:success] = "This item has been fulfilled"
  end

end
