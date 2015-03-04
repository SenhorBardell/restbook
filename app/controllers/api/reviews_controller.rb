class Api::ReviewsController < ApplicationController
  protect_from_forgery with: :null_session

  def show
    render json: {status: 'show'}
  end

  def store
    render json: {status: 'post new review'}
  end

end