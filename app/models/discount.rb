class Discount <ApplicationRecord

  belongs_to :item

  validates_presence_of :description,
                        :discount_amount,
                        :minimum_quantity

  def adjusted_item_price
    discount = item.price * discount_amount
    item.price - discount
  end
end
