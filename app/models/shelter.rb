class Shelter < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :pets, dependent: :destroy

  validates_presence_of :name

  def pet_count
    pets.count
  end

  def average_review_rating
    return 0 if reviews.empty?

    reviews.average(:rating)
  end

  def number_applications
    pets.sum do |pet|
      pet.application_count
    end
  end

  def pending_pets?
    pets.find_all do |pet|
      pet.approved_application?
    end.empty?
  end
end
