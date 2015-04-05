class AreaNormalSerializer < ActiveModel::Serializer
  attributes :id, :type, :orders
  # has_many :today_orders

  def type
    object.area_type
  end

  def orders
    object.today_orders.map{|order| {
        id: order.id,
        datetime: order.datetime,
        status: order.status
    }}
  end

end