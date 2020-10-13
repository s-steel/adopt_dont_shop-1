class ReviewsController < ApplicationController
  def new
    @review_id = Review.find(params[:id])
  end

  def create
    review = Review.new(review_params)

    review.save
    redirect_to "/shelters/#{review_params[:shelter_id]}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating, :image, :shelter_id, :user_id)
  end
end
