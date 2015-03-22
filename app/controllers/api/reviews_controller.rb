class Api::ReviewsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  # Reviews feed
  def index
    render json: Review.order(id: :desc).offset(@offset).limit(@limit)
                     .includes(:place), each_serializer: ReviewFeedSerializer, root: nil
  end

  # Reviews by place id
  def show
    render json: Place.find(params[:id])
                     .reviews.order(id: :desc).includes(:user)
                     .offset(@offset).limit(@limit)
                     .order(id: :desc), root: nil
  end

  def store
    render json: Place.find(params[:id]).reviews.includes(:user).create(
        user_id: @user.id,
        text: params[:text],
        vote: params[:vote]
    ), root: nil
  end

end