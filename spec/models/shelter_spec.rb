require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'attributes' do
    it 'has a name, address, city, state, and zip' do
      shelter = build(:shelter)

      expect(shelter).to respond_to(:name)
      expect(shelter).to respond_to(:address)
      expect(shelter).to respond_to(:city)
      expect(shelter).to respond_to(:state)
      expect(shelter).to respond_to(:zip)
    end
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe 'instance methods' do

    it '#pet_count' do
      shelter = create(:shelter, :with_pets, pet_count: 4)

      expect(shelter.pet_count).to eq(4)
    end

    it '#average_review_rating' do
      shelter = create(:shelter)
      review1 = create(:review, rating: 1, shelter: shelter)
      review2 = create(:review, rating: 3, shelter: shelter)
      review3 = create(:review, rating: 5, shelter: shelter)

      expect(shelter.average_review_rating.round(1)).to eq(3)
    end

    it '#number_applications' do
      shelter = create(:shelter, :with_pets, pet_count: 4)
      create(:application_pet, pet: shelter.pets[0])
      create(:application_pet, pet: shelter.pets[1])
      create(:application_pet, pet: shelter.pets[2])

      expect(shelter.number_applications).to eq(3)
    end

    it '#pending_pets?' do
      shelter = create(:shelter, :with_pets, pet_count: 4)
      create(:application_pet, pet: shelter.pets[0])
      create(:application_pet, pet: shelter.pets[1])

      expect(shelter.pending_pets?).to eq(true)

      application = create(:user_application, status: 'Approved')
      create(:application_pet, user_application: application, pet: shelter.pets[2])

      expect(shelter.pending_pets?).to eq(false)
    end
  end
end
