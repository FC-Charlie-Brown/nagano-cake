class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details
    enum payment_way: { card: 0, bank: 1 }

end
