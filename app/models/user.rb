class User < ApplicationRecord
  has_many :reviews

  def reviews
    Review.where(user_id: self.id)
  end
end
