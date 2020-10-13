class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    user = User.find_by(name: params[:username])
    review = Review.new(review_params)
    review[:shelter_id] = shelter.id
    review[:user_id] = user.id
    review.save
    redirect_to "/shelters/#{review[:shelter_id]}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating, :image, :shelter_id, :user_id)
  end
end
