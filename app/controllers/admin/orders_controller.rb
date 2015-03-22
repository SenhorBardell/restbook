class Admin::OrdersController < ApplicationController
  before_filter :admin_authenticate

  def index
    if params.has_key?(:status)
      render json: @place.orders.status(params.has_key?(:status) ? params[:status] : 'pending')
                       .order(id: :desc).includes(:user)
                       .limit(@limit).offset(@offset), each_serializer: AdminOrderSerializer, root: nil
    elsif params.has_key?(:id)
      render json: @place.orders.find(params[:id]), serializer: AdminOrderSerializer, root: nil
    else
      render json: @place.orders.status('pending')
                 .order(id: :desc).includes(:user)
                 .limit(@limit).offset(@offset),
             each_serializer: AdminOrderSerializer
      end
  end

  def update
    render json: @place
                     .orders
                     .update(
                         params[:id],
                         params.permit(:status, :table, :datetime)
                     ), serializer: AdminOrderSerializer
  end

  private

  def admin_authenticate
    authenticate_or_request_with_http_token do |token, options|
      @place = AdminDevice.find_by(auth: token).place
    end
  end

end