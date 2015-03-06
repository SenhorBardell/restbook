class Api::ReviewsController < ApplicationController
  before_filter :authenticate

  def index
    render json: {status: @user}
  end

  def show
    render json: {status: 'show'}
  end

  def store
    render json: {status: 'post new review'}
  end

end