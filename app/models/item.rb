class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  
  def tax_price(price)
    puts price*1.08
  end
  
end
