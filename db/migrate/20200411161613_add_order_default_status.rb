class AddOrderDefaultStatus < ActiveRecord::Migration[5.1]
  def change
    change_column_default :orders, :status, "Pending"
  end
end
