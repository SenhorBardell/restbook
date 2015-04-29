class Api::OrdersController < ApplicationController
  before_filter :authenticate

  def index
    if params.has_key?(:status)
      if params[:status] == 'archived'
        render json: @user.orders.where('datetime < ? OR status not in (?)', 30.minutes.since(Time.now), [:pending, :accepted])
                         .includes(:place).pag(@offset, @limit),
               each_serializer: ClientOrderSerializer
      elsif params[:status] == 'current'
        render json: @user.orders.where('datetime > ? AND status in (?)', 30.minutes.since(Time.now), [:pending, :accepted])
                   .includes(:place).pag(@offset, @limit),
               each_serializer: ClientOrderSerializer
      else
        render json: @user.orders.status(params[:status])
                         .includes(:place).pag(@offset, @limit),
               each_serializer: ClientOrderSerializer
      end
    else
      render json: @user.orders
                       .includes(:place)
                       .pag(@offset, @limit),
             each_serializer: ClientOrderSerializer
    end
  end

  def store
    pp params[:datetime]
    render json: @user.orders.includes(:place)
                     .create(params.permit(:place_id, :datetime, :info, :guests)),
           serializer: ClientOrderSerializer
  end

  def destroy
    order = @user.orders.find(params[:id])
    order.update(status: 'deleted')
    render nothing: true, status: 204
  end

end