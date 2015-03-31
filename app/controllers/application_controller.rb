class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :paginate

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = Device.find_by(auth: token).user
    end
  end

  def paginate
    @limit = params[:size].blank? ? 20 : params[:size].to_i
    @offset = params[:last].blank? ? 0 : params[:last].to_i * @limit
  end

  def default_serializer_options
    {root: false}
  end
end
