class Public::OrdersController < ApplicationController
  
  def index
    # @orders = current_customer.orders
  end

  	def show
	 # @order = Order.find(params[:id])
  #   @order_details = @order.order_details
	end

  def new
    @order = Order.new
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    # @address = Address.new(address_params)
    # @address.save
    # ↑どうする？
    @order = current_customer.orders.new(order_params)
    @order.save
    redirect_to confirm_path
  end


  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    # @addresses = Address.where(customer_id: current_customer.id)
    @orders = Order.where(customer_id: current_customer.id)
    @order = Order.new(
      customer: current_customer,
      payment_way: params[:order][:payment_way],
      address: params[:order][:address]
    )
    @radio_value = params[:order][:address]
    
    if params[:order][:address] == 0
      
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    
    elsif params[:order][:addresses] == 1
      address 
    
  #   elsif  params[:order][:addresses] == 2
      
  end

  end

  def complete
  end

 private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :status, :payment_way, :sum, :shipping_fee, :customer_id)
  end
  
end