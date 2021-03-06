require 'rails_helper'

describe 'shelter edit page' do
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
    visit "/shelters/#{shelter.id}/edit"
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

  it 'can see title' do
    expect(page).to have_content("Edit #{shelter.name}'s Information")
  end

  it 'can see form' do
    expect(page.has_field?(:name, with: shelter.name)).to eq(true)
    expect(page.has_field?(:address, with: shelter.address)).to eq(true)
    expect(page.has_field?(:city, with: shelter.city)).to eq(true)
    expect(page.has_field?(:state, with: shelter.state)).to eq(true)
    expect(page.has_field?(:zip, with: shelter.zip)).to eq(true)
  end

  it 'can edit a shelter form' do
    fill_in :name, with: 'Test Shelter Edited'
    fill_in :address, with: '1 Test Edit Dr.'
    fill_in :city, with: 'Pittsburgh'
    fill_in :state, with: 'PA'
    fill_in :zip, with: '15432'
    click_button 'Update Shelter Information'

    expect(page).to have_content('Test Shelter Edited')
    expect(page).to have_content('1 Test Edit Dr.')
    expect(page).to have_content('Pittsburgh')
    expect(page).to have_content('PA')
    expect(page).to have_content('15432')
  end

  it 'can see submit button' do
    expect(page).to have_button('Update Shelter Information')
  end
end
