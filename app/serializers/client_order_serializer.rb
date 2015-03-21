class ClientOrderSerializer < ActiveModel::Serializer
  attributes :id, :datetime, :info, :guests, :status, :table

  has_one :user
end