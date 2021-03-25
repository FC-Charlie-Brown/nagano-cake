class Admin::OrdersController < ApplicationController
  before_action :require_admin
  def index
    @orders = Order.page(params[:page]).per(5)
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
    @customer = Customer.find(@order.customer_id)
    @order_details =  OrderDetail.where(order_id: params[:id])
    @total_price = 0

    @order_details.each do |order_detail|
      price = (order_detail.item.price.to_i*1.1).to_i
      amount = order_detail.amount.to_i 
      item_total_price = price * amount
      @total_price += item_total_price
    end
	end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(params[:id])
  end
  
  private
  def require_admin
    unless admin_signed_in?
      redirect_to top_path
    end
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
