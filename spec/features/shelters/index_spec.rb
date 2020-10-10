require 'rails_helper'

describe 'shelter index page' do
  it 'can see pets index link' do
    visit '/shelters'
    expect(page).to have_link('Pets Index')
    click_link('Pets Index')
    expect(page).to have_current_path('/pets')
  end

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

  it 'can click on update link' do
    shelter = Shelter.create(name: 'Test Shelter 1')

    visit '/shelters'
    expect(page).to have_link("Edit #{shelter.name}")

    click_link ("Edit #{shelter.name}")
    expect(page).to have_current_path("/shelters/#{shelter.id}/edit") 
  end

  it 'can delete shelter' do
    shelter = Shelter.create(name: 'Test Shelter 1')

    visit '/shelters'
    expect(page).to have_button("Delete #{shelter.name}")

    click_button ("Delete #{shelter.name}")
    expect(page).to have_current_path("/shelters") 
  end
end
