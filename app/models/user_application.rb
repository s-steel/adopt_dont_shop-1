class UserApplication < ApplicationRecord
  belongs_to :user
  has_many :application_pets
  has_many :pets, through: :application_pets

  def user_name
    user.name
  end

  def user_address
    user.address
  end

  def user_city
    user.city
  end

  def user_state
    user.state
  end

  def user_zip
    user.zip
  end

  def add_pet(pet)
    return if self.pets.include?(pet)
    self.pets << pet
  end
end
