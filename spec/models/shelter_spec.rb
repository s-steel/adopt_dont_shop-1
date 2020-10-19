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
end
