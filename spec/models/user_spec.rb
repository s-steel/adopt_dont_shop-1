require 'rails_helper'

describe User, type: :model do
  describe 'relationships' do
    it { should have_many :reviews  }
  end

  describe 'class methods' do
    let!(:shelter) { create(:shelter, name: 'Best Test Shelter') }
    let!(:user) { create(:user, name: 'Jim') }
    let!(:review1) { create(:review, title: 'Best Shelter!', rating: 4,
                          content: 'Great!', shelter_id: shelter.id, user_id: user.id) }
    let!(:review2) { create(:review, title: 'Ok Shelter!', rating: 1,
                          content: 'so-so', shelter_id: shelter.id, user_id: user.id) }

    it '.reviews' do
      expect(user.reviews).to eq([review1, review2])
    end

    it '.review_best_rating' do
      expect(user.review_best_rating).to eq(review1)
    end

    it '.review_worst_rating' do
      expect(user.review_worst_rating).to eq(review2)
    end

    it '.average_review_rating' do
      expect(user.average_review_rating).to eq(2.5)
    end
  end
end
