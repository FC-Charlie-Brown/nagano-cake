class Public::CartItemsController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :require_sign_in
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_update_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    redirect_to cart_items_path
  end

  def create
    item = CartItem.new(cart_item_params)
    item.save
    redirect_to cart_items_path
  end

  private
  def require_sign_in
    unless customer_signed_in?
      flash[:error] = "ログインしてください"
      redirect_to new_customer_session_path
    end
  end

  def cart_item_params
    params.permit(:item_id,:customer_id,:amount)
  end

  def cart_item_update_params
    params.require(:cart_item).permit(:amount) 
  end
end
