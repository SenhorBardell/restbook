class Api::PlacesController < ApplicationController
  def index
    if params.has_key? :flags
      render json: Place.where('flags @> ARRAY[?]::varchar[]', params[:flags]).offset(@offset).limit(@limit)
    else
      render json: Place.offset(@offset).limit(@limit)
    end
  end

  def show
    render json: Place.find(params[:id])
  end
end