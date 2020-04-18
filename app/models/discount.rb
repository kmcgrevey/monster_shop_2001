class Discount <ApplicationRecord

  belongs_to :item

  validates_presence_of :description,
                        :discount_amount,
                        :minimum_quantity

end
