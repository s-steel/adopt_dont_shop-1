require 'rails_helper'

describe Pet, type: :model do
  describe 'attributes' do
    it 'has a name, age, sex, image, status, and description' do
      pet = build(:pet)

      expect(pet).to respond_to(:name)
      expect(pet).to respond_to(:approximate_age)
      expect(pet).to respond_to(:sex)
      expect(pet).to respond_to(:image)
      expect(pet).to respond_to(:status)
      expect(pet).to respond_to(:description)
      expect(pet).to respond_to(:shelter_id)
    end
  end

  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :application_pets }
    it { should have_many(:user_applications).through(:application_pets) }
  end

  describe 'instance methods' do
    it '#shelter_name' do
      pet = create(:pet)

      expect(pet.shelter_name).to eq(pet.shelter.name)
    end

    it '#approval_status' do
      pet = create(:pet)
      application1 = create(:application_pet, pet: pet)
      application2 = create(:application_pet, pet: pet, pet_approval_status: 'Approved')
      application3 = create(:application_pet, pet: pet, pet_approval_status: 'Rejected')

      expect(pet.approval_status(application1.id)).to be_nil
      expect(pet.approval_status(application2.id)).to eq('Approved')
      expect(pet.approval_status(application3.id)).to eq('Rejected')
    end 
  end

  describe 'class methods' do
    it '.search' do
      pet1 = create(:pet, name: 'Wesley')
      pet2 = create(:pet, name: 'Mila')
      pet3 = create(:pet, name: 'Winston')

      expect(Pet.search('Edna')).to eq([])
      expect(Pet.search('w')).to eq([pet1, pet3])
    end
  end
end
