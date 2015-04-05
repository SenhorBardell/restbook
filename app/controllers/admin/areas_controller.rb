class Admin::AreasController < ApplicationController
  before_filter :admin_authenticate

  def avaiable
    #Today
    return render json: @place.areas.includes(:today_orders), each_serializer: AreaNormalSerializer unless params.has_key? :datetime

    render json: @place.areas.includes(:orders)
                     .where("extract(day from orders.datetime) = #{params[:datetime].to_time.strftime('%d')}")
                     .where("extract(month from orders.datetime) = #{params[:datetime].to_time.strftime('%m')}")
                     .references(:orders).concat(@place.areas).uniq
  end
end