class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :logo, :img, :desc,
             :hours, :flags, :address, :phone

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
        number: object.phone ? object.phone.to_i : nil
    }
  end

  def img
    AMAZON_URL + object.img.to_s
  end

  def logo
    AMAZON_URL + object.logo.to_s
  end
end
