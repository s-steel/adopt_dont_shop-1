class ApplicationPet < ApplicationRecord
  belongs_to :user_application
  belongs_to :pet
end
