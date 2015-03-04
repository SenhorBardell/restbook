class Api::OrdersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: {status: 'index'}
  end

  def store
    render json: {status: 'store'}
  end

end