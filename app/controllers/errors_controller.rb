class ErrorsController < ApplicationController

  def e404
    render json: {status: 404, info: 'Not found'}
  end

  def e500
    render json: {status: 500, info: 'Server error'}
  end
end