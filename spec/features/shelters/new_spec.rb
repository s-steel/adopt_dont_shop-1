require 'rails_helper'

describe 'shelter new page' do
  before do
    visit '/shelters/new'
  end

  it 'can see title' do
    expect(page).to have_content('Create a new Shelter')
  end

  it 'can see form' do
    expect(page.has_field?('Name', type: 'text')).to eq(true)
    expect(page.has_field?('Address', type: 'text')).to eq(true)
    expect(page.has_field?('State', type: 'text')).to eq(true)
    expect(page.has_field?('City', type: 'text')).to eq(true)
    expect(page.has_field?('zip', type: 'text')).to eq(true)
  end

  it 'can see submit button' do
    expect(page).to have_button('Create Shelter')
  end
end
