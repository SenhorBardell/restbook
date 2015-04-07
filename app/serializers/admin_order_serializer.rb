class AdminOrderSerializer < ActiveModel::Serializer
  attributes :id, :datetime, :info, :guests, :status, :area_id, :created_at

  has_one :user
end