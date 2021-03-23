class Address < ApplicationRecord
  belongs_to :customer
# ここに郵便とかまとめたのを定義する
    def total_address
       '〒' + ' ' + postal_code + ' ' + address + ' ' + name
    end
end
