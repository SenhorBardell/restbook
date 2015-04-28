class ClientOrderSerializer < ActiveModel::Serializer
  attributes :id, :datetime, :info, :guests, :area_id, :status

  has_one :place

  AMAZON_URL = 'https://s3-eu-west-1.amazonaws.com/elasticbeanstalk-eu-west-1-719074273155/img/'

  def place
    {
        id: object.place.id,
        name: object.place.name,
        type: object.place.place_type,
        logo: AMAZON_URL + object.place.logo
    }
  end
end