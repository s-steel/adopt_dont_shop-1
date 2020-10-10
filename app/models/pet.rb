class Pet < ApplicationRecord
  belongs_to :shelter

  def shelter_name(shelter_id)
    Shelter.joins(:pets).find_by(id: shelter_id).name
  end
end
