class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :addresses
  has_many :cart_items
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :last_name, presence: true, on: :update
  validates :first_name, presence: true, on: :update
  validates :postal_code, presence: true, on: :update
  validates :address, presence: true, on: :update
  validates :telephone_number, presence: true, on: :update

end
