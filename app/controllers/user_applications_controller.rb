class UserApplicationsController < ApplicationController
  def show
    @application = UserApplication.find(params[:id])
    @search = Pet.search(params[:search])
  end

  def new
  end

  def create
    application = UserApplication.new(user_app_params)

    if User.exists?(name: params[:username])
      application.user_id = User.select(:id).where(name: params[:username]).first.id
    else
      flash[:error] = 'ERROR: User could not be found'
      return redirect_to "/applications/new"
    end

    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

  def user_app_params
    params.permit(:description, :status)
    .with_defaults(status: 'In Progress')
  end
end
