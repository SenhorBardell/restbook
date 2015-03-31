class AdminOrderSerializer < ActiveModel::Serializer
  attributes :id, :datetime, :info, :guests, :status, :table, :created_at

  has_one :user
end