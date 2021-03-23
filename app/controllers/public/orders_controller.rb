class Public::OrdersController < ApplicationController
  def index
    @orders = Order.where(customer_id: current_customer.id)
    @orders.each do |order| 
      name_var = "@name#{order.id}"
      name_value = ''

      order_details =  OrderDetail.where(order_id: order.id)
      order_details.each do |order_detail|
        
        order_items = Item.where(id: order_detail.item_id)
        item_amount = order_detail.amount
        
        order_items.each do |order_item|
          
          name_value += order_item.name
          name_value += "\n"
          
        end
      end

      eval("#{name_var} = name_value") 
    end
    
  end

  def show
	  @order = Order.find(params[:id])
    @order_details =  OrderDetail.where(order_id: params[:id])
    @total_price = 0
    @order_details.each do |order_detail|
      price = (order_detail.item.price.to_i*1.1).to_i
      amount = order_detail.amount.to_i 
      item_total_price = price * amount
      @total_price += item_total_price
    end
	end




  def new
    @oder = Order.new
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    order = Order.new(order_params)
    order.save
    #カートの中身空にする
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new

      order_detail.order_id = order.id
      order_detail.item_id = cart_item.item_id
      order_detail.amount = cart_item.amount
      target_item = Item.find(order_detail.item_id)
      order_detail.price = target_item.price
      order_detail.making_status = 0

      order_detail.save
    end

    @cart_items.destroy_all

    #ありがとうページへ
    redirect_to complete_path
  end
  
  def create_new_address
    @new_address = Address.new(address_params)
    @new_address.customer_id = current_customer.id
    @new_address.save
    redirect_to confirm_path
  end



  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @payment_way = params[:order][:payment_way]
    @address_radio = params[:order][:address_radio]
    @current_customer = Customer.find(current_customer.id)
    @shipping_fee = 800
    #↓後で再代入
    @submit_address
    @submit_postal_code
    if @address_radio == 'my_address'
      @submit_address = @current_customer.address
      @submit_postal_code = @current_customer.postal_code

      @order_address = "〒" + @current_customer.postal_code + @current_customer.address

      @shipping_name = @current_customer.last_name + @current_customer.first_name

    elsif @address_radio == 'already_address'
      #logger.debug("address_id: "+ params[:order][:already_address])
      address_id = params[:order][:already_address]
      @target_address = Address.find(address_id);
      @order_address = "〒" + @target_address.postal_code + @target_address.address
      @shipping_name = @target_address.name
      @submit_address = @target_address.address
      @submit_postal_code = @target_address.postal_code
    elsif @address_radio == 'new_address'
      address = Address.new({
        customer_id:@current_customer.id,
        postal_code:params[:order][:postal_code],
        address:params[:order][:address],
        name:params[:order][:name]})
      address.save
      

      @target_address = address
      @order_address = "〒" +@target_address.postal_code + @target_address.address
      @shipping_name = @target_address.name
      
      @submit_address = @target_address.address
      @submit_postal_code = @target_address.postal_code
    end

    #注文データ作成
    @order = Order.new

  end


  def complete

  end

 private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :status, :payment_way, :sum, :shipping_fee, :customer_id)
  end
  
end