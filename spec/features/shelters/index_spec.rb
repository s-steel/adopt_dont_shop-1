require 'rails_helper'

describe 'shelter index page' do
  let!(:shelter1) { create(:shelter, name: 'Test Shelter 1') }
  let!(:shelter2) { create(:shelter, name: 'Test Shelter 2') }

  before do
    visit '/shelters'
  end

  it 'can see pets index link' do
    expect(page).to have_link('Pets Index')
    click_link('Pets Index')
    expect(page).to have_current_path('/pets')
  end

  it 'can see title' do
    expect(page).to have_content('All Shelters')
  end

  it 'can see a new shelter link' do
    expect(page).to have_link('New Shelter')
  end

  it 'can see show links for each shelter name' do
    expect(page).to have_link(shelter1.name)
    expect(page).to have_link(shelter2.name)
  end

  it 'can click on update link' do
    expect(page).to have_link("Edit #{shelter1.name}")

    click_link "Edit #{shelter1.name}"
    expect(page).to have_current_path("/shelters/#{shelter1.id}/edit")
  end

  it 'can delete shelter' do
    expect(page).to have_button("Delete #{shelter1.name}")

    click_button "Delete #{shelter1.name}"
    expect(page).to have_current_path('/shelters')
  end

  it 'can click on new shelter link' do
    expect(page).to have_link('Create New Shelter')
    
    click_link 'Create New Shelter'
    expect(page).to have_current_path('/shelters/new')
  end
end
