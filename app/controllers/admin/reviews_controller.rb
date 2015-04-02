class Admin::ReviewsController < ApplicationController
  before_filter :admin_authenticate

  def index
    render json: @place.reviews.order(id: :desc).includes(:user)
               .offset(@offset).limit(@limit)
  end

  def admin_authenticate
    authenticate_or_request_with_http_token do |token, options|
      @place = AdminDevice.find_by(auth: token).place
    end
  end
end