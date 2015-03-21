class Place < ActiveRecord::Base
  has_many :reviews
  has_many :orders
  has_many :admin_devices

  # def as_json(options=nil)
  #   {
  #       id: self.id,
  #       name: self.name,
  #       type: self.place_type,
  #       logo: self.logo,
  #       img: self.img,
  #       desc: self.desc,
  #       hours: self.hours,
  #       flags: self.flags,
  #       address: {
  #           city: self.city,
  #           street: self.street,
  #           building: self.building
  #       },
  #       phone: {
  #           type: 'Администратор',
  #           number: 79211040339
  #       }
  #   }
  # end
end
