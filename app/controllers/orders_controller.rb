class OrdersController <ApplicationController

  def new
  end

  def show
  end

  def create
    user = current_user
    order = user.orders.create(order_params)
    if order.save
      order.update(status: 0)
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
        end
      session.delete(:cart)
      redirect_to "/profile/orders"
      flash[:success] = "Your order was created!"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def update
    order = Order.find(params[:id])
    order.update(status: 2)
    redirect_to "/admin/dashboard"
  end

  def destroy
    order = Order.find(params[:id])
    order.cancel_order
    redirect_to "/profile"
    flash[:success] = "Your order has been cancelled!"
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
