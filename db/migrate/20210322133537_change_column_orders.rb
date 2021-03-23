class ChangeColumnOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :address, :string, null: false
  end
end
