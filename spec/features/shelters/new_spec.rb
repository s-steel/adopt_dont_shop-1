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

  it 'can fill out a new shelter form' do
    visit "/shelters/new"
    fill_in 'Name', with: 'Brentwood Animal Rescue'
    fill_in 'Address', with: '78 Greenwood Ln.'
    fill_in 'City', with: 'Brentwood'
    fill_in 'State', with: 'TN'
    fill_in 'zip', with: '37218'
    click_button 'Create Shelter'
    expect(page).to have_content('Brentwood Animal Rescue')

    click_link 'Brentwood Animal Rescue'
    expect(page).to have_content('Brentwood Animal Rescue')
    expect(page).to have_content('78 Greenwood Ln.')
    expect(page).to have_content('Brentwood')
    expect(page).to have_content('TN')
    expect(page).to have_content('37218')
  end

  it 'can see submit button' do
    expect(page).to have_button('Create Shelter')
  end
end
