class OrderSerializer < ActiveModel::Serializer
  attributes :id, :datetime, :guests, :status
end