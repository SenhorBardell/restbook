class Admin::AuthorizationController < ApplicationController

  def attach
    return render json: {status: 401, info: 'Wrong Args'},
                  status: 401 unless params[:pass] && params[:login] && params[:udid] && params[:token]

    @place = Place.find_by(login: params[:login])

    return render json: {status: 401, info: 'Wrong pass'}, status: 401 unless params[:pass] == @place.pass

    @admin = @place.admin_devices.find_or_create_by(
        udid: params[:udid],
        auth: SecureRandom.base64(32),
        token: params[:token]
    )

    render json: {
               udid: @admin.udid,
               auth: @admin.auth,
               token: @admin.token,
               place: {
                   id: @place.id,
                   name: @place.name
               }
           }
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    render json: {status: 404, info: 'Not found'}, status: 404
  end

end