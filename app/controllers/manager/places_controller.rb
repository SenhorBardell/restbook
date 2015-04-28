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
    s3 = Aws::S3::Client.new

    image_key = SecureRandom.uuid
    image = s3.put_object(
      body: params[:place][:img],
      key: 'img/' + image_key  + ext(params[:place][:img]),
      bucket: ENV['S3_BUCKET']
    )

    logo_key = SecureRandom.uuid
    logo = s3.put_object(
      body: params[:place][:logo],
      key: 'img/' + logo_key + ext(params[:place][:logo]),
      bucket: ENV['S3_BUCKET']
    )

    @place = Place.new(params.require(:place).permit(
                           :name, :place_type, :desc, :city, :street,
                           :building, :long, :lat, :hours, :flags))

    @place.img = image_key + ext(params[:place][:img])
    @place.logo = logo_key + ext(params[:place][:logo])
    @place.save
    redirect_to manager_place_url(@place)
  end

  def ext(file)
    File.extname(file.original_filename) if file
  end

  # HTML Form
  def show
    # AMAZON_URL = 'https://s3-eu-west-1.amazonaws.com/elasticbeanstalk-eu-west-1-719074273155/img/'
    @place = Place.find(params[:id])
  end

  # HTML Form
  def edit
    @place = Place.find(params[:id])
  end

  def update

  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    redirect_to manager_places_path
  end
end