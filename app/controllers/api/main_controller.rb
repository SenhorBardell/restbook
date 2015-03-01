class Api::MainController < ApplicationController
  protect_from_forgery with: :null_session

  def root
    render json: {status: 'Everything is awesome'}
  end
end