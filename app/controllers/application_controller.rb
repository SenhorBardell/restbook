class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :paginate

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @device = Device.includes(:user).find_by(auth: token)
      unless @device.blank?
        @user = @device.user
      end
    end
  end

  def paginate
    @limit = params[:size].blank? ? params[:size] : 20
    @offset = params[:last].blank? ? 0 : params[:last].to_i * @limit
  end
end
