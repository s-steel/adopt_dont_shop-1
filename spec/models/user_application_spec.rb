require 'rails_helper'

describe UserApplication, type: :model do
  # describe 'validations' do
  #   it { should validate_presence_of :description}
  # end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'class methods' do
    let!(:shelter1) { create(:shelter, name: 'Best Test Shelter') }
    let!(:user) { create(:user, name: 'Rick', address: '1 st.', city: 'Denver', state: 'CO', zip: 12244) }

    let!(:pet1) { create(:pet, name: 'Edna', approximate_age: 6, sex: 'Female', shelter_id: shelter1.id) }
    let!(:pet2) { create(:pet, name: 'Sean', approximate_age: 12, sex: 'Male', shelter_id: shelter1.id) }
    let!(:pet3) { create(:pet, name: 'Taylor', approximate_age: 1, sex: 'Female', shelter_id: shelter1.id) }

    let!(:user_application) { create(:user_application, description: "I'd love to Adopt!", status: "Pending", user_id: user.id)  }
    let!(:application_pet1) { create(:application_pet, user_application_id: user_application.id, pet_id: pet1.id) }
    let!(:application_pet2) { create(:application_pet, user_application_id: user_application.id, pet_id: pet2.id) }

    it '#user_name' do
      expect(user_application.user_name).to eq(user.name)
    end

    it '#user_address' do
      expect(user_application.user_address).to eq(user.address)
    end

    it '#user_city' do
      expect(user_application.user_city).to eq(user.city)
    end

    it '#user_state' do
      expect(user_application.user_state).to eq(user.state)
    end

    it '#user_zip' do
      expect(user_application.user_zip).to eq(user.zip)
    end

    it '#add_pet' do
      expect(user_application.add_pet(pet3)).to eq(user_application.pets)
    end
  end
end
