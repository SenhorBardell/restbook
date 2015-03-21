class Order < ActiveRecord::Base
  belongs_to :place
  belongs_to :user

  scope :status, ->(status) {where(status: status)}

  def self.for_client
    all.map{|order| {
        id: order.id,
        datetime: order.datetime,
        info: order.info,
        guests: order.guests,
        status: order.status,
        place: {
            id: order.place_id,
            name: order.place.name,
            type: order.place.place_type,
            logo: order.place.logo
        }
    }}
  end

  def for_client
    {
        id: self.id,
        datetime: self.datetime,
        info: self.info,
        guests: self.guests,
        status: self.status,
        place: {
            id: self.place.id,
            name: self.place.name,
            type: self.place.place_type,
            logo: self.place.logo
        }
    }
  end
  #
  # def self.for_admin
  #   all.map{|order| {
  #       id: order.id,
  #       datetime: order.datetime,
  #       info: order.info,
  #       guests: order.guests,
  #       status: order.status,
  #       user: {
  #           id: order.user.id,
  #           name: order.user.name,
  #           phone: order.user.phone
  #       }
  #   }}
  # end
  #
  # def for_admin
  #   self.as_json(include: :user, except: [
  #                                  :place_id,
  #                                  :user_id,
  #                                  :created_at,
  #                                  :updated_at
  #                              ])
  # end

  def table
    read_attribute(:table).to_i
  end

  def guests
    read_attribute(:guests).to_i
  end
end
