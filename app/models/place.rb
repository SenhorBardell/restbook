class Place < ActiveRecord::Base
  has_many :reviews
  has_many :orders
  has_many :admin_devices
  has_many :areas
  belongs_to :city

  scope :pag, ->(offset, limit) {offset(offset).limit(limit)}

  validates :name, presence: true

  # def flags
  #   @flags = self.flags
  # end
end
