require 'rails_helper'

describe Pet, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end

  describe 'class methods' do
    let(:shelter1) { create(:shelter, name: 'Best Test Shelter') }
    let(:shelter2) { create(:shelter, name: 'Coolest Shelter') }
    let(:pet) { create(:pet, name: 'Edna', approximate_age: 6, sex: 'Female', shelter_id: shelter1.id) }

    it '.shelter_name' do
      expect(pet.shelter_name(pet.shelter_id)).to eq('Best Test Shelter')
    end
  end
end
