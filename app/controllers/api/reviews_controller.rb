class Api::ReviewsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  # Reviews feed
  def index
    render json: Review.order(id: :desc).offset(@offset).limit(@limit)
                     .includes(:place).map{ |review| {
               id: review.id,
               text: review.text,
               vote: review.vote,
               created_at: review.created_at,
               place: {
                   id: review.place.id,
                   type: review.place.place_type,
                   logo: review.place.logo,
                   name: review.place.name
               }
           }}
  end

  # Reviews by place id
  def show
    render json: Place.find(params[:id])
                     .reviews.order(id: :desc).includes(:user)
                     .offset(@offset).limit(@limit)
                     .order(id: :desc)
  end

  def store
    render json: Place.find(params[:id]).reviews.includes(:user).create(
        user_id: @user.id,
        text: params[:text],
        vote: params[:vote]
    )
  end

end