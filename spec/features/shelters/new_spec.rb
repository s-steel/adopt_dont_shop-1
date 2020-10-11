require 'rails_helper'

describe 'shelter new page' do
  before do
    visit '/shelters/new'
  end

  it 'can see title' do
    expect(page).to have_content('Create a New Shelter')
  end

  it 'can see form' do
    expect(page.has_field?(:name, type: 'text')).to eq(true)
    expect(page.has_field?(:address, type: 'text')).to eq(true)
    expect(page.has_field?(:state, type: 'text')).to eq(true)
    expect(page.has_field?(:city, type: 'text')).to eq(true)
    expect(page.has_field?(:zip, type: 'text')).to eq(true)
  end

  it 'can fill out a new shelter form' do
    visit '/shelters'

    click_link 'New Shelter'
    expect(page).to have_current_path('/shelters/new')

    fill_in :name, with: 'Brentwood Animal Rescue'
    fill_in :address, with: '78 Greenwood Ln.'
    fill_in :city, with: 'Brentwood'
    fill_in :state, with: 'TN'
    fill_in :zip, with: '37218'

    click_button 'Create Shelter'
    expect(page).to have_current_path('/shelters')
    expect(page).to have_content('Brentwood Animal Rescue')

    click_link 'Brentwood Animal Rescue'
    expect(page).to have_content('Brentwood Animal Rescue')
    expect(page).to have_content('78 Greenwood Ln.')
    expect(page).to have_content('Brentwood')
    expect(page).to have_content('TN')
    expect(page).to have_content('37218')
  end
end
