class Api::OrdersController < ApplicationController
  before_filter :authenticate

  def index
    render json: @user.orders.includes(:place)
  end

  def store
    render json: @user.orders.includes(:place).create(
               place_id: params[:place_id],
               datetime: params[:datetime],
               info: params[:info],
               guests: params[:guests]
           )
  end

end