class Admin::OrderDetailsController < ApplicationController
  before_action :require_admin
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)

    redirect_back fallback_location:admin_order_path(order_detail.order_id)
  end
  
  private
  def require_admin
    unless admin_signed_in?
      redirect_to top_path
    end
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
