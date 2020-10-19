class AdminApplicationsController < ApplicationController
  def show
    @admin_application = UserApplication.find(params[:id])
    @pets = Pet.search(params[:search])
  end

  def update
    app = ApplicationPet.where(user_application_id: params[:id], pet_id: params[:pet_id])
    app.update(pet_approval_status)

    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def pet_approval_status
    params.permit(:pet_approval_status)
  end
end
