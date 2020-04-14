class Merchant::ItemStatusController < Merchant::BaseController

  def update
    item = Item.find(params[:id])
    item.update(active?: !item.active?)
    if item.active?
      flash[:success] = "'#{item.name}' has been marked active and is now for sale"
    else
      flash[:success] = "'#{item.name}' has been marked inactive and is no longer for sale"
    end
    redirect_to("/merchant/items")
  end
  
end
