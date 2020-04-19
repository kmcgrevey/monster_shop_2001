class Merchant::DiscountsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def show
    @discount = Discount.find(params[:discount_id])
  end

  def new
    item = Item.find(params[:item_id])
    @discount = item.discounts.new
  end

  def create
    item = Item.find(params[:item_id])
    discount = item.discounts.new(discount_params)
    if discount.save
      flash[:success] = "New discount added successfully"
      redirect_to "/merchant/items/discounts/#{discount.id}"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

  def edit
    @discount = Discount.find(params[:discount_id])
  end


  def update
    discount = Discount.find(params[:discount_id])
    if discount.update(discount_params)
      flash[:success] = "Discount has been updated!"
      redirect_to "/merchant/items/discounts/#{discount.id}"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

private

  def discount_params
    params[:discount].permit(:description, :discount_amount, :minimum_quantity)
  end

end
