class UserApplication < ApplicationRecord
  belongs_to :user 
  has_many :application_pets
  has_many :pets, through: :application_pets

  def user_name
    User.joins(:user_applications).find_by(id: user_id).name 
  end

  def user_address
    User.joins(:user_applications).find_by(id: user_id).address 
  end

  def user_city
    User.joins(:user_applications).find_by(id: user_id).city 
  end

  def user_state
    User.joins(:user_applications).find_by(id: user_id).state 
  end
  
  def user_zip
    User.joins(:user_applications).find_by(id: user_id).zip 
  end

  def pets
    pet_ids = ApplicationPets.where(user_application_id: id).pluck(:pet_id)

    pet_ids.map do |pet_id|
      Pet.find_by(id: pet_id)
    end
  end
end
