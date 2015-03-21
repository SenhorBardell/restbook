class Review < ActiveRecord::Base
  belongs_to :place
  belongs_to :user

  # def as_json(options=nil)
  #   {
  #       id: self.id,
  #       text: self.text,
  #       vote: self.vote,
  #       created_at: self.created_at,
  #       user: {
  #           id: self.user.id,
  #           name: self.user.name
  #       }
  #   }
  # end
end