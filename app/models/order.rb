class Order < ApplicationRecord
    enum payment_way: { card: 0, bank: 1 }
end
