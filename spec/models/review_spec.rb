require 'rails_helper'

describe Review, type: :model do
  describe 'attributes' do
    it 'has title, content, image, rating' do
      review = build(:review)

      expect(review).to respond_to(:title)
      expect(review).to respond_to(:content)
      expect(review).to respond_to(:image)
      expect(review).to respond_to(:rating)
      expect(review).to respond_to(:title)
    end 

    it 'has shelter_id and user_id' do
      review = build(:review)

      expect(review).to respond_to(:shelter_id)
      expect(review).to respond_to(:user_id)
    end
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :content }
  end

  describe 'relationships' do
    it { should belong_to :shelter }
    it { should belong_to :user }
  end

  describe 'class methods' do
    let(:review) { create(:review) }
   
    it '.user_name' do
      expect(review.user_name).to eq(review.user.name)
    end 
  end
end
