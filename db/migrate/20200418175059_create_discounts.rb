class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :description
      t.float :discount_amount
      t.integer :minimum_quantity
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
