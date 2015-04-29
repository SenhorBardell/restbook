class Manager::ReviewsController < ApplicationController

  def index
    @place = Place.find(params[:place_id])
    @reviews = @place.reviews
  end

  def edit
    @review = Review.find(params[:id])
  end

end