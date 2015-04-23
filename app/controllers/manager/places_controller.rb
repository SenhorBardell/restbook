class Manager::PlacesController < ApplicationController

  # List
  def index
    @places = Place.all
  end

  # HTML Form
  def new
    @place = Place.new
  end

  def create
    @place = Place.new(params.require(:place).permit(:name))
    @place.save
    redirect_to manager_place_url(@place)
  end

  # HTML Form
  def show
    @place = Place.find(params[:id])
  end

  # HTML Form
  def edit
    @place = Place.find(params[:id])
  end

  def update

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to manager_places_path
  end
end