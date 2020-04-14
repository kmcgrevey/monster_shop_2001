class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:success] = "Item information has been updated!"
      redirect_to "/merchant/items"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

  private

  def item_params
    params[:item].permit(:name, :description, :price, :image, :status, :inventory)
  end

end
