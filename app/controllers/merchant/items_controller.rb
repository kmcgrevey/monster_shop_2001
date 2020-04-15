class Merchant::ItemsController < Merchant::BaseController

  def new
    merchant = Merchant.find(current_user.merchant_id)
    @item = merchant.items.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    if @item.save
      flash[:success] = "#{@item.name} has been added to your inventory."
      redirect_to "/merchant/items"
    else
      flash.now[:error] = @item.errors.full_messages.to_sentence
      render "/merchant/items/new"
    end
  end

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
      flash[:error] = item.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

  def destroy
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:success] = "Item has been deleted!"

    redirect_to "/merchant/items"
  end

  private

  def item_params
    params[:item].permit(:name, :description, :price, :image, :status, :inventory)
  end



  private

  def item_params
    params.require(:item).permit(:name,:description,:price,:inventory,:image)
  end

end
