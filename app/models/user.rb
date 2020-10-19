class User < ApplicationRecord
  has_many :reviews
  has_many :user_applications

  def average_review_rating
    return 0 if reviews.empty?

    reviews.average(:rating).round(1)
  end

  def review_best_rating
    return nil if reviews.empty?

    reviews.order(rating: :desc).limit(1).first
  end

  def review_worst_rating
    return nil if reviews.empty?

    reviews.order(:rating).limit(1).first
  end
end
