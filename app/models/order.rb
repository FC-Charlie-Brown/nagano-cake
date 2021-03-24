class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details
    enum payment_way:{ card: 0, bank: 1 }
    enum order_status: {wait: 0,confirm: 1,making: 2, shipping: 3, shipped: 4}
    
end
