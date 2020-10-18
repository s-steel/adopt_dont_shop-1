require 'rails_helper'

describe Review, type: :model do
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
