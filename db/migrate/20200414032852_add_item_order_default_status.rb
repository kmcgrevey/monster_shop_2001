class AddItemOrderDefaultStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default :item_orders, :status, "Unfulfilled"
  end
end
