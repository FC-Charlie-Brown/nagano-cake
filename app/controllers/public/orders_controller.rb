class Public::OrdersController < ApplicationController
  def index
  end

  def show
    @orders = Order.all
  end

  def new
    @oder = Order.new
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.save
    @order = Order.new(order_params)
    @post.save
    redirect_to confirm_path
  end


  def confirm
    @orders = Order.all
  end

  def complete
  end

 private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :status, :payment_way, :sum, :shipping_fee, :customer_id)
  end
  
end