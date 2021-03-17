class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|

      t.timestamps
      t.references :item, null: false
      t.integer :amount, null: false
    end
  end
end
