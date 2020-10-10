require 'rails_helper'

describe 'pet index page' do
  let(:shelter) do
    Shelter.create(
      name: 'Test Shelter 1',
      address: '1 Test St.',
      city: 'Denver',
      state: 'CO',
      zip: 12345
    )
  end

  let(:pet1) do
    Pet.create(
      name: 'Taylor', 
      image: 'none', 
      description: 'cute', 
      sex: 'male',
      approximate_age: 30, 
    ) 
  end

  let(:pet2) do
    Pet.create(
      name: 'Tayla',
      image: 'none',
      description: 'very cute',
      sex: 'male',
      approximate_age: 27,
    )
  end

  before do
    visit '/pets'
  end

  it 'can see title' do
    expect(page).to have_content('All Pets') 
  end

  it 'can see pets' do
    factory_pet = build(:pet, name: 'Taylor')
require 'pry'; binding.pry
    save_and_open_page
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)
  end
end
