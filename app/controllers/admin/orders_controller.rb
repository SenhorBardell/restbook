class Admin::OrdersController < ApplicationController
  before_filter :admin_authenticate

  def index
    if params.has_key?(:status)
      # TODO consider using closure function to pass status
      if params[:status] == 'archived'
        return render json: @place.orders
                                .where('datetime < ? OR status not in (?)', 30.minutes.from_now, [:pending, :accepted]) # datetime maybe?
                                .includes(:user)
                                .limit(@limit).offset(@offset), each_serializer: AdminOrderSerializer
      elsif params[:status] == 'current'
        return render json: @place.orders
                                .where('datetime > ? AND status IN (?)', 30.minutes.from_now, [:pending, :accepted])
                                .includes(:user).limit(@limit).offset(@offset), each_serializer: AdminOrderSerializer
      end
        render json: @place.orders.status(params[:status])
                         .includes(:user)
                         .limit(@limit).offset(@offset), each_serializer: AdminOrderSerializer

    elsif params.has_key?(:id)
      render json: @place.orders.find(params[:id]), serializer: AdminOrderSerializer
    else
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
                         params.permit(:status, :datetime, :area_id)
                     ), serializer: AdminOrderSerializer
  end

  private

end