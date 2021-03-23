class Admin::CustomersController < ApplicationController
  before_action :require_admin

  def index
    @customers = Customer.page(params[:page]).per(5)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(params[:id])
    else
      render :edit
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end


  private
  def require_admin
    unless admin_signed_in?
      redirect_to top_path
    end
  end

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:is_deleted)
  end

end
