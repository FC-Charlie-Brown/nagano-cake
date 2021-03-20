class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_item
  def tax_price(price)
    puts price*1.08
  end
  
end
