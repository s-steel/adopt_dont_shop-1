class Pet < ApplicationRecord
  belongs_to :shelter

  def shelter_name(id)
    Shelter.joins(:pets).uniq.find do |shelter|
      shelter.id == id
    end.name
  end
end
