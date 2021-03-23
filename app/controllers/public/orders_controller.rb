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
    # @address = Address.new(address_params)
    # @address.save
    # ↑どうする？
    @order = current_customer.orders.new(order_params)
    @order.save
    redirect_to confirm_path
  end
  
  def create_new_address
    @new_address = Address.new(address_params)
    @new_address.customer_id = current_customer.id
    @new_address.save
    redirect_to confirm_path
  end



  def confirm
    @orders = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @addresses = Address.where(customer_id: current_customer.id)
    @orders = Order.where(customer_id: current_customer.id)
    @order = Order.new(
      customer: current_customer,
      payment_way: params[:order][:payment_way],
      address: params[:order][:address]
    )
    
    if params[:order][:address] == 0
      
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    
    elsif params[:order][:address] == 1
    
    elsif params[:order][:address] == 2
    @nfew_address = Address.new(address_params)
    @new_address.customer_id = current_customer.id
      @new_address.save
      redirect_to confirm_path
     
    end

  end


  def complete
  end

 private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :status, :payment_way, :sum, :shipping_fee, :customer_id)
  end
  
end