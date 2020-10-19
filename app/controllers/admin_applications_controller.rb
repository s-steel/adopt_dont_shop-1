class AdminApplicationsController < ApplicationController
  def show
    @admin_application = UserApplication.find(params[:id])
  end

  def update
    status = params[:pet_status]
    redirect_to "/admin/applications/#{params[:id]}?status=#{status}"
  end
end
