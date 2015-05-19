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

    @place = Place.new(place_params)

    if params[:place][:img]

      image_key = SecureRandom.uuid
      image = s3.put_object(
        body: params[:place][:img],
        key: 'img/' + image_key  + ext(params[:place][:img]),
        bucket: ENV['S3_BUCKET']
      )

      @place.img = image_key + ext(params[:place][:img])
    end

    if params[:place][:logo]

      logo_key = SecureRandom.uuid
      logo = s3.put_object(
        body: params[:place][:logo],
        key: 'img/' + logo_key + ext(params[:place][:logo]),
        bucket: ENV['S3_BUCKET']
      )
      @place.logo = logo_key + ext(params[:place][:logo])

    end

    if @place.save
      redirect_to manager_place_url(@place)
    else
      render 'new'
    end
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
    @place = Place.find(params[:id])

    if params[:place][:img]

      image_key = SecureRandom.uuid
      image = s3.put_object(
          body: params[:place][:img],
          key: 'img/' + image_key  + ext(params[:place][:img]),
          bucket: ENV['S3_BUCKET']
      )

      @place.img = image_key + ext(params[:place][:img])
    end

    if params[:place][:logo]

      logo_key = SecureRandom.uuid
      logo = s3.put_object(
          body: params[:place][:logo],
          key: 'img/' + logo_key + ext(params[:place][:logo]),
          bucket: ENV['S3_BUCKET']
      )
      @place.logo = logo_key + ext(params[:place][:logo])

    end

    if @place.update(place_params)
      redirect_to manager_place_url(@place)
    else
      render 'edit'
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    redirect_to manager_places_path
  end

  private

  def place_params
    params.require(:place).permit(
        :name, :place_type, :desc, :city_id, :street,
        :building, :long, :lat, :hours, flags: []
    )
  end

  def ext(file)
    File.extname(file.original_filename) if file
  end
end