class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status:{packaged: 0, pending: 1, shipped: 2, cancelled: 3}

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_count
    item_orders.sum('quantity')
  end
end
