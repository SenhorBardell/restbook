class AreaSerializer < ActiveModel::Serializer
  attributes :id, :type, :orders

  def type
    object.area_type
  end

  def orders
    if object.association(:orders).loaded?
      object.orders.map{|order| {id: order.id, datetime: order.datetime, status: order.status}}
    else
      []
    end
  end

end