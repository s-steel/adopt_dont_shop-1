class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
   shelter_id = params[:shelter_id].keys.pop.to_i
   pet = Pet.new({
      image: params[:image],
      name: params[:name],
      description: params[:description],
      approximate_age: params[:approximate_age],
      sex: params[:sex],
      status: 'Adoptable',
      shelter_id: shelter_id
    })

    pet.save
    redirect_to "/shelters/#{shelter_id}/pets"
  end
end
