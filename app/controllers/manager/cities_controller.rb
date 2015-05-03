class Manager::CitiesController < ApplicationController

  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to manager_cities_url
    else
      render 'new'
    end
  end

  def update
    @city = City.find(params[:id])

    if @city.update(city_params)
      redirect_to manager_cities_url
    else
      render 'edit'
    end
  end

  def edit
    @city = City.find(params[:id])
  end

  def destroy
    @city = City.find params[:id]
    @city.destroy

    redirect_to manager_cities_url
  end

  private

  def city_params
    params.require(:city).permit(:name)
  end

end