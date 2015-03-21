class Admin::AuthorizationController < ApplicationController

  def attach
    return render json: {status: 401, info: 'Wrong Args'} unless params[:pass] && params[:id] && params[:udid]

    @place = Place.find(params[:id])

    return render json: {status: 401, info: 'Wrong pass'} unless params[:pass] == @place.pass

    render json: @place.admin_devices.find_or_create_by(udid: params[:udid], auth: '123')
 end

end