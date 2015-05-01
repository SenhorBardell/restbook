class Manager::CitiesController < ApplicationController

  def index
    @cities = City.all
  end

  def edit

  end

  def destroy

  end

end