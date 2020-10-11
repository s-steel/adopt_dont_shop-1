require 'rails_helper'

describe 'shelter show page' do
  let(:shelter) do
    create(
      :shelter,
      name: 'Test Shelter 1',
      address: '1 Test St.',
      city: 'Denver',
      state: 'CO',
      zip: 12345
    )
  end

  before do
    visit "shelters/#{shelter.id}"
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

  it 'can see shelter information' do
    expect(page).to have_content(shelter.name.to_s)
    expect(page).to have_content(shelter.address.to_s)
    expect(page).to have_content(shelter.city.to_s)
    expect(page).to have_content(shelter.state.to_s)
    expect(page).to have_content(shelter.zip.to_s)
  end

  it 'can see all pets a shelter link' do
    expect(page).to have_link("See All Pets at #{shelter.name}")
    click_link("See All Pets at #{shelter.name}")
    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")
  end

  it 'can see update shelter link' do
    expect(page).to have_link('Update Shelter')
  end

  it 'can delete a shelter' do
    expect(page).to have_button('Delete Shelter')

    click_button 'Delete Shelter'
    expect(page).to have_current_path('/shelters')
  end
end
