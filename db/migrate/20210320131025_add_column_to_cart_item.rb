class AddColumnToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :customer, index: true
  end
end
