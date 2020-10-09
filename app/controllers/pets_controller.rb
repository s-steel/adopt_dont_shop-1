class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:id]
  end

  def create
    pet = Pet.new(pet_params)

    pet.save
    redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex, :shelter_id)
  end
end
