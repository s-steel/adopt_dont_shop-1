class Shelter < ApplicationRecord
  has_many :pets, dependent: :restrict_with_exception
end
