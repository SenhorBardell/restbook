class Area < ActiveRecord::Base
  belongs_to :place
  has_many :orders
  has_many :today_orders,
           -> {where(datetime: Time.now.beginning_of_day..Time.now.end_of_day)},
           class_name: 'Order'
end