class User < ActiveRecord::Base
  has_many :devices
  has_many :orders
  has_many :reviews

  def phone
    read_attribute(:phone).to_i
  end
end
