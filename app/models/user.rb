class User < ActiveRecord::Base
  has_many :devices
  has_many :orders

  def as_json(options=nil)
    {
        name: self.name,
        phone: self.phone.to_i
    }
  end
end
