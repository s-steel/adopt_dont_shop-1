class AdminApplicationsController < ApplicationController
  def show
    @admin_application = UserApplication.find(params[:id])
    @pets = Pet.search(params[:search])
  end

  def update
    app = ApplicationPet.where(user_application_id: params[:id], pet_id: params[:pet_id])
    app.update(pet_approval_status)

    application_pet = ApplicationPet.where(user_application_id: params[:id])
    if application_pet.where("pet_approval_status = ?", "Approved").count == application_pet.count
      user_app = UserApplication.find(params[:id])
      user_app[:status] = 'Approved'
      user_app.save
    end

    unless application_pet.where("pet_approval_status = ?", "Rejected").empty?
      user_app = UserApplication.find(params[:id])
      user_app[:status] = 'Rejected'
      user_app.save
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def pet_approval_status
    params.permit(:pet_approval_status)
  end
end
