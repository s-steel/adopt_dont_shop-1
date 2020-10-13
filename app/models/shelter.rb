class Shelter < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :pets, dependent: :restrict_with_exception
end
