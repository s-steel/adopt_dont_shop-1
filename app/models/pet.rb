class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :user_applications, through: :application_pets

  validates_presence_of :name

  def self.search(name)
    where(name: name)
  end

  def shelter_name
    self.shelter.name
  end
end
