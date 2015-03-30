module Pushable
  extend ActiveSupport::Concern

  def push(tokens, platform)
    service = Rpush::Gcm::Notification.new
    service.app = Rpush::Gcm::App.find_by_name(platform)
    service.registration_ids = tokens #TODO maybe use without array
    service.data = {message: "Hi mom!"}
    service.save!
  end

  # module ClassMethods
  #   def
  # end
end