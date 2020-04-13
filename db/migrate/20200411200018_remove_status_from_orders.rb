class RemoveStatusFromOrders < ActiveRecord::Migration[5.1]
  def up
    remove_column :orders, :status, :string
  end

  def down
    add_column :orders, :status, :string
  end
  
end
