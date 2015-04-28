class Place < ActiveRecord::Base
  has_many :reviews
  has_many :orders
  has_many :admin_devices
  has_many :areas

  scope :pag, ->(offset, limit) {offset(offset).limit(limit)}
end
