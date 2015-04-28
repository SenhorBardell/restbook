class ReviewFeedSerializer < ActiveModel::Serializer
  attributes :id, :text, :vote, :created_at

  has_one(:place)

  AMAZON_URL = 'https://s3-eu-west-1.amazonaws.com/elasticbeanstalk-eu-west-1-719074273155/img/'

  def place
    {
        id: object.place.id,
        type: object.place.place_type,
        logo: AMAZON_URL + object.place.logo,
        name: object.place.name
    }
  end
end