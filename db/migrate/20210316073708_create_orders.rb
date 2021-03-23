class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.timestamps
      t.references :customer, null: false
      t.integer :shipping_fee, null: false
      t.integer :sum, null: false
      t.integer :payment_way, null: false, default: 0
      t.integer :status, null: false
      t.string :name, null: false
      t.integer :address, null: false
      t.integer :postal_code, null: false
    end
  end
end
