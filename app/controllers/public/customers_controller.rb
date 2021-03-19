class Public::CustomersController < ApplicationController
  before_action :require_sign_in

  def show

  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    customer.update(customer_params)
    redirect_to my_page_path
  end

  def unsubscribe
  end

  def withdraw
    customer = current_customer
    customer.is_deleted = true
    customer.save
    redirect_to top_path
  end

  private
  def require_sign_in
    unless customer_signed_in?
      flash[:error] = "ログインしてください"
      redirect_to new_customer_session_path 
    end
  end

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number)
  end
end
