class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.timestamps
      t.references :genre, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :image_id, null: false
      t.boolean :sale_status, default: false, null: false
    end
  end
end
