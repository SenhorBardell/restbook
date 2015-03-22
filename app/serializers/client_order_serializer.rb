class ClientOrderSerializer < ActiveModel::Serializer
  attributes :id, :datetime, :info, :guests, :table, :status

  has_one :place

  def place
    {
        id: object.place.id,
        name: object.place.name,
        type: object.place.place_type,
        logo: object.place.logo
    }
  end
end