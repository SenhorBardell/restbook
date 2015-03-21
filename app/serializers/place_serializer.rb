class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :logo, :img, :desc,
             :hours, :flags, :address, :phone

  def type
    object.place_type
  end

  def address
    {
        city: object.city,
        street: object.street,
        building: object.building
    }
  end

  def phone
    {
        type: 'Администратор',
        number: 79211040339
    }
  end
end
