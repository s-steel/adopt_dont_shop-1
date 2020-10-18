require 'rails_helper'

describe UserApplication, type: :model do
  describe 'attributes' do
    it 'has description, status and user_id' do
      application = build(:user_application)

      expect(application).to respond_to(:description)
      expect(application).to respond_to(:status)
      expect(application).to respond_to(:user_id)
    end 
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'class methods' do
    it '#user_name' do
      application = create(:user_application)

      expect(application.user_name).to eq(application.user.name)
    end

    it '#user_address' do
      application = create(:user_application)

      expect(application.user_address).to eq(application.user.address)
    end

    it '#user_city' do
      application = create(:user_application)

      expect(application.user_city).to eq(application.user.city)
    end

    it '#user_state' do
      application = create(:user_application)

      expect(application.user_state).to eq(application.user.state)
    end

    it '#user_zip' do
      application = create(:user_application)

      expect(application.user_zip).to eq(application.user.zip)
    end

    it '#add_pet' do
      application = create(:user_application, :with_pets, pet_count: 3)
      expect(application.pets.count).to eq(3)

      application.add_pet(create(:pet))
      expect(application.pets.count).to eq(4)
    end
  end
end
