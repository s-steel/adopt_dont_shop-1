class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :user_applications, through: :application_pets

  validates_presence_of :name

  def self.search(pet_name)
    return [] if pet_name.nil?

    where('lower(name) like ?', "%#{pet_name.downcase}%")
  end

  def shelter_name
    self.shelter.name
  end

  def approval_status(application_id)
     application_pets.where(user_application_id: application_id).first.pet_approval_status
  end

  def approved_application?
    !(user_applications.select(:status).where("status = ?", "Approved").empty?)
  end

  def application_count
    user_applications.count
  end
end
