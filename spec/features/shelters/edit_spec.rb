require 'rails_helper'

describe 'shelter edit page' do
  let(:shelter) do
    Shelter.create(
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

  it 'can see title' do
    expect(page).to have_content('Edit Shelter')
  end

  it 'can see form' do
    expect(page.has_field?('Name', with: shelter.name.to_s)).to eq(true)
    expect(page.has_field?('Address', with: shelter.address.to_s)).to eq(true)
    expect(page.has_field?('State', with: shelter.state.to_s)).to eq(true)
    expect(page.has_field?('zip', with: shelter.zip.to_s)).to eq(true)
  end

  it 'can see submit button' do
    expect(page).to have_button('Update Shelter Information')
  end
end
