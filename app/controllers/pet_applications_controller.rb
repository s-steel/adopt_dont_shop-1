class PetApplicationsController < ApplicationController
  def index
    pet = Pet.find(params[:id])
require 'pry'; binding.pry
  end
end
