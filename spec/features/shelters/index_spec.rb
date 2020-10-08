require 'rails_helper'

describe 'shelter index page' do
  it 'can see title' do
    visit '/shelters'
    expect(page).to have_content('All Shelters')
  end

  it 'can see a new shelter link' do
    visit '/shelters'
    expect(page).to have_link('New Shelter')
  end

  it 'can see show links for each shelter name' do
    shelter1 = Shelter.create(name: 'Test Shelter 1')
    shelter2 = Shelter.create(name: 'Test Shelter 2')

    visit '/shelters'
    expect(page).to have_link(shelter1.name)
    expect(page).to have_link(shelter2.name)
  end
end
