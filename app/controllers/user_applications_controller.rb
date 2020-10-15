class UserApplicationsController < ApplicationController
  def show
    @application = UserApplication.find(params[:id])
  end
end
