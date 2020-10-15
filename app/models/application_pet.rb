class ApplicationPet < ApplicationRecord
  has_many :user_applications
  has_many :pets
end
