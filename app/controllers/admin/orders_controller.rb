class Admin::OrdersController < ApplicationController
  before_filter :admin_authenticate

  def index
    if params.has_key?(:id)
      render json: @place.orders.find(params[:id]).for_admin
    else
      render json: @place.orders.status(params.has_key?(:status) ? params[:status] : 'pending')
                 .order(id: :desc).includes(:user)
                 .limit(@limit).offset(@offset), each_serializer: AdminOrderSerializer, root: nil
    end
  end

  def update
    render json: @place
                     .orders
                     .update(
                         params[:id],
                         params.permit(:status, :table, :datetime)
                     ).for_admin
  end

  private

  def admin_authenticate
    authenticate_or_request_with_http_token do |token, options|
      @place = AdminDevice.find_by(auth: token).place
    end
  end

end