class SheltersController < ApplicationController
  def index
    @shelters = ['shelter 1', 'shelter 2']
  end

  def new
  end

  def create
    shelter = Shelter.new({
      name:    params[:shelter][:name]
      address: params[:shelter][:address]
      city:    params[:shelter][:city]
      state:   params[:shelter][:state]
      zip:     params[:shelter][:zip]
      })

    shelter.save
    redirect_to '/shelters'
  end
end
