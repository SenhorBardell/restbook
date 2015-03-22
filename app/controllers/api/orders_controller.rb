class Api::OrdersController < ApplicationController
  before_filter :authenticate

  def index
    render json: @user.orders
                     .order(id: :desc).includes(:place)
                     .offset(@offset).limit(@limit),
           each_serializer: ClientOrderSerializer
  end

  def store
    render json: @user.orders.includes(:place)
                     .create(params.permit(:place_id, :datetime, :info, :guests)), serializer: ClientOrderSerializer
  end

  def destroy
    @user.orders.find(params[:id]).destroy
    render nothing: true, status: 204
  end

end