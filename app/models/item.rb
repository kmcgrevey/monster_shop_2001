class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        # :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, :inventory, greater_than: 0

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.most_popular_5
    joins(:item_orders).group(:id)
                       .order('SUM (item_orders.quantity) DESC')
                       .limit(5)
  end

  def self.least_popular_5
    joins(:item_orders).group(:id)
                       .order('SUM (item_orders.quantity) ASC')
                       .limit(5)
  end

  def qty_purchased
    item_orders.sum(:quantity)
  end

  def order_qty_purchased(order)
  item_orders.where(order_id: order)
               .sum(:quantity)

  end

  def subtotal(order)
    price * order_qty_purchased(order)
  end

  def status
    return "active" if active?
      "inactive"
  end

end
