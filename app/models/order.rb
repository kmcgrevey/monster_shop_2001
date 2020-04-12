class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status:{pending: 0, packaged: 1, shipped: 2, cancelled: 3}

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_count
    item_orders.sum('quantity')
  end

  def self.pending
    where(status: 0)
  end

  def self.packaged
    where(status: 1)
  end

  def self.shipped
    where(status: 2)
  end

  def self.cancelled
    where(status: 3)
  end
end
