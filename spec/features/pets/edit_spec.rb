require 'rails_helper'

describe 'pet edit page' do
  let(:shelter) { create(:shelter, name: 'Best Test Shelter') }
  let(:pet) { create(:pet, name: 'Edna', approximate_age: 6, sex: 'Female', shelter_id: shelter.id) }

  before do
    visit "/pets/#{pet.id}/edit"
  end

  it 'can see shelters index link' do
    expect(page).to have_link('Shelters Index')
    click_link('Shelters Index')
    expect(page).to have_current_path('/shelters')
  end

  it 'can see pets index link' do
    expect(page).to have_link('Pets Index')
    click_link('Pets Index')
    expect(page).to have_current_path('/pets')
  end
end
