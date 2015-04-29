class Manager::AreasController < ApplicationController

  def index
    @place = Place.find(params[:place_id])
    @areas = @place.areas
  end

end