class PetApplicationsController < ApplicationController
  def index
    pet = Pet.find(params[:id])
    @user_apps = pet.user_applications
  end
end
