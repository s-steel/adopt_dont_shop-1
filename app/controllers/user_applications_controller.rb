class UserApplicationsController < ApplicationController
  def show
    @application = UserApplication.find(params[:id])
    @pets = Pet.search(params[:search])
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

  def update
    application = UserApplication.find(params[:id])

    if user_app_params[:description] == ""
      flash[:error] = 'ERROR: You must fill out why you would be a good pet owner'
      return redirect_to "/applications/#{params[:id]}"
    end
    
    application.update(user_app_params)
    application[:status] = 'Pending'
    application.save
    redirect_to "/applications/#{params[:id]}"
  end

  def update_pets
    application = UserApplication.find(params[:id])
    application.add_pet(Pet.find(params[:pet_id]))

    redirect_to "/applications/#{params[:id]}"
  end

  private

  def user_app_params
    params.permit(:description, :status)
    .with_defaults(status: 'In Progress')
  end
end
