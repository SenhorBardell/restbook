class Api::PlacesController < ApplicationController
  def index
    if params.has_key? :flags
      render json: Place.where('flags @> ARRAY[?]::varchar[]', params[:flags]).where(city_id: params[:city])
                       .pag(@offset, @limit)
    elsif params.has_key? :debug
      render json: Place.where(city_id: params[:city]).pag(@offset, @limit)
    else
      render json: Place.where.not('flags @> ARRAY[?]::varchar[]', :hidden)
                       .where(city_id: params[:city])
                       .pag(@offset, @limit)
    end
  end

  def show
    render json: Place.find(params[:id])
  end
end