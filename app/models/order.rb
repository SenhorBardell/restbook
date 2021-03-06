class Order < ActiveRecord::Base
  include Pushable

  belongs_to :place
  belongs_to :user
  belongs_to :area

  default_scope {order(id: :desc)}
  scope :status, ->(status) {where(status: status)}
  scope :status_not, ->(status) {where.not(status: status)}
  scope :pag, ->(offset, limit) {offset(offset).limit(limit)}
  scope :today, -> {where(datetime: Time.now.beginning_of_day..Time.now.end_of_day)}
  scope :day, ->(day) {where("extract(day from datetime) = #{day.strftime('%d')}")}

  #TODO default scope with order

  after_save :add_to_push_queue
  after_update :add_to_push_queue

  def add_to_push_queue
    push(Device.where("user_id = #{self.user_id}").map(&:token), "android_app")
    push(self.place.admin_devices.map(&:token), "android_app")
  end

  # Serialization methods

  def table
    read_attribute(:table).to_i
  end

  def guests
    read_attribute(:guests).to_i
  end
end
