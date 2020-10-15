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
    let!(:shelter) { create(:shelter, name: 'Best Test Shelter') }
    let!(:user) { create(:user, name: 'Jim') }
    let!(:review) { create(:review, title: 'Best Shelter!', rating: 4, 
                          content: 'Great!', shelter_id: shelter.id, user_id: user.id) }
   
    it '.user_name' do
      expect(review.user_name).to eq('Jim')
    end 
  end
end
