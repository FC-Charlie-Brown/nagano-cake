class Public::AddressesController < ApplicationController
  before_action :require_sign_in

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to addresses_path
  end

  def edit
     @address = Address.find(params[:id])
  end

  def update
     @address = Address.find(params[:id])
     @address.update(address_params)
     redirect_to addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:customer_id,:postal_code,:address,:name)
  end

  def require_sign_in
    unless customer_signed_in?
      flash[:error] = "ログインしてください"
      redirect_to new_customer_session_path
    end
  end

end
