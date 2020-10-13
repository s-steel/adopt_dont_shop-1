class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    review = Review.new(review_params)
    review.shelter_id = Shelter.find(params[:id]).id
    review.user_id = User.find_by(name: params[:username]).id
    review.save
    redirect_to "/shelters/#{review[:shelter_id]}"
  end

  def edit
    @shelter = Shelter.find(params[:id])
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)
    review.save
    redirect_to "/shelters/#{params[:id]}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating, :image)
  end
end
