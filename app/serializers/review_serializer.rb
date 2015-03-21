class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :text, :vote, :created_at

  has_one :user
end