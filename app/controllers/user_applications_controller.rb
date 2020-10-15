class UserApplicationsController < ApplicationController
  def show
    @application = UserApplication.find(params[:id])
  end

  def new
  end

  def create
    application = UserApplication.new(user_app_params)
    application.user_id = User.select(:id).where(name: params[:username]).first.id

    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

  def user_app_params
    params.permit(:description, :status)
    .with_defaults(status: 'In Progress')
  end
end
