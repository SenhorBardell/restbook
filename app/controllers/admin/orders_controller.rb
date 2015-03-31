class Admin::OrdersController < ApplicationController
  before_filter :admin_authenticate

  def index
    if params.has_key?(:status)
      # TODO consider using closure function to pass status
      if params[:status] == 'archived'
        pp "Status archived"
        return render json: @place.orders.status_not('pending').includes(:user)
                          .limit(@limit).offset(@offset), each_serializer: AdminOrderSerializer
      end
      pp "Status #{params[:status]}"
      render json: @place.orders.status(params[:status])
                       .includes(:user)
                       .limit(@limit).offset(@offset), each_serializer: AdminOrderSerializer
    elsif params.has_key?(:id)
      pp "No status"
      render json: @place.orders.find(params[:id]), serializer: AdminOrderSerializer
    else
      pp "Default status"
      render json: @place.orders.status('pending')
                 .includes(:user)
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