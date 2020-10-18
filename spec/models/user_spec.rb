require 'rails_helper'

describe User, type: :model do
  describe 'relationships' do
    it { should have_many :reviews }
    it { should have_many :user_applications }
  end

  describe 'instance methods' do
    it '#review_best_rating' do
      user1 = create(:user)
      user2 = create(:user)
      review1 = create(:review, user: user1, rating: 2)
      review2 = create(:review, user: user1, rating: 3)
      review3 = create(:review, user: user1, rating: 5)

      expect(user1.review_best_rating).to eq(review3)
      expect(user2.review_best_rating).to be_nil
    end

    it '#review_worst_rating' do
      user1 = create(:user)
      user2 = create(:user)
      review1 = create(:review, user: user1, rating: 2)
      review2 = create(:review, user: user1, rating: 3)
      review3 = create(:review, user: user1, rating: 5)

      expect(user1.review_worst_rating).to eq(review1)
      expect(user2.review_worst_rating).to be_nil
    end

    it '#average_review_rating' do
      user = create(:user)
      review1 = create(:review, user: user, rating: 2)
      review2 = create(:review, user: user, rating: 3)
      review3 = create(:review, user: user, rating: 5)

      expect(user.average_review_rating).to eq(3.3)
    end
  end
end
