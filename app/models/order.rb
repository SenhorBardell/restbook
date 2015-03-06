class Order < ActiveRecord::Base
  belongs_to :place
  def as_json(options=nil)
    {
        id: self.id,
        datetime: self.datetime,
        info: self.info,
        guests: self.guests,
        status: self.status,
        place: {
            id: self.place_id,
            name: self.place.name,
            type: self.place.place_type
        }
    }
  end
end
