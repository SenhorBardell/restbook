class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :logo, :img, :desc,
             :hours, :flags, :address, :phone

  AMAZON_URL = 'https://s3-eu-west-1.amazonaws.com/elasticbeanstalk-eu-west-1-719074273155/img/'

  def type
    object.place_type
  end

  def city
    object.city
  end

  def address
    {
        city: city.name,
        street: object.street,
        building: object.building
    }
  end

  def phone
    {
        type: 'Администратор',
        number: object.phone
    }
  end

  def img
    AMAZON_URL + object.img.to_s
  end

  def logo
    AMAZON_URL + object.logo.to_s
  end
end
