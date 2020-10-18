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
    let(:pet) { create(:pet) }

    it '#shelter_name' do
      expect(pet.shelter_name).to eq(pet.shelter.name)
    end

    # it '#search' do
    #   expect(self.search('Edna')).to eq(pet.name)
    # end
  end
end
