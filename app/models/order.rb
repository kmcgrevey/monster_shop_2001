class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders


  enum status:{pending: 0, packaged: 1, shipped: 2, cancelled: 3}

  def self.order_by_status
    order(:status)
  end

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_count
    item_orders.sum('quantity')
  end

  def cancel_order
    items_to_cancel = Item.joins(:item_orders).where("item_orders.status = 'Fulfilled'")
    items_to_cancel.map do |item|
      refill_merchant(item)
    end
    item_orders.update(status: :Unfulfilled)
    update(status: 3)
  end

  def refill_merchant(item)
    item.inventory = item.inventory + item_orders.where(item_id: item.id)
                                                 .sum('quantity')
    item.update(inventory: item.inventory)
  end

  def fulfill_item(item)
    item_orders.where(item_id: item.id)
             .update(status: :Fulfilled)
    item.inventory = item.inventory - item_orders.where(item_id: item.id)
                                                 .sum('quantity')
    item.update(inventory: item.inventory)
    if item_orders.count == item_orders.where(status: :Fulfilled).count
      self.status = 1
    else
      self.status = 0
    end
  end

  def merchant_item_quantity(merchant_id)
    items.where(merchant_id: merchant_id).sum('quantity')
  end

  def merchant_item_subtotal(merchant_id)
    subtotal = items.where(merchant_id: merchant_id).group(:id).sum('items.price * quantity')
    subtotal.values.sum
  end

  def merchant_items(merchant_id)
    items.where(merchant_id: merchant_id)
  end
end
