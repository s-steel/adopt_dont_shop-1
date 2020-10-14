class User < ApplicationRecord
  has_many :reviews

  def reviews
    Review.where(user_id: self.id)
  end

  def average_review_rating
    return 0 if reviews.empty?

    reviews.average(:rating).round(1)    
  end
end
