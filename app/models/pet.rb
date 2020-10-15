class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :user_applications, through: :application_pets

  validates_presence_of :name

  def shelter_name(shelter_id)
    Shelter.joins(:pets).find_by(id: shelter_id).name
  end
end
