class ClientOrderSerializer < ActiveModel::Serializer
  attributes :id, :datetime, :info, :guests, :area_id, :status

  has_one :place

  def place
    {
        id: object.place.id,
        name: object.place.name,
        type: object.place.place_type,
        logo: AMAZON_URL + object.place.logo.to_s
    }
  end
end