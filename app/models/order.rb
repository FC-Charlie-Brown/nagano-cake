class Order < ApplicationRecord
    belongs_to :customer
    enum payment_way: { card: 0, bank: 1 }

end
