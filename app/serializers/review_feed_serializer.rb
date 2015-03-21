class ReviewFeedSerializer < ActiveModel::Serializer
  attributes :id, :text, :vote, :created_at

  has_one(:place)

  def place
    {
        id: object.place.id,
        type: object.place.place_type,
        logo: object.place.logo,
        name: object.place.name
    }
  end
end