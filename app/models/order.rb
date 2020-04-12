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
    update(status: :Cancelled)
    item_orders.update(status: :Unfulfilled)
  #Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
  end

  def fulfill_item(item)
    item_orders.where(item_id: item.id)
             .update(status: :Fulfilled)

    if item_orders.count == item_orders.where(status: :Fulfilled).count
      self.status = "Packaged"
    else
      self.status = "Pending"
    end
  end
end
