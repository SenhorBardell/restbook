class Api::PlacesController < ApplicationController
  def index
    render json: Place.offset(@offset).limit(@limit), root: nil
  end

  def show
    render json: Place.find(params[:id])
  end
end