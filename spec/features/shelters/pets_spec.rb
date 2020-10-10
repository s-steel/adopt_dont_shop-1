require 'rails_helper'

describe 'shelter pets index page' do
  let!(:shelter) { create(:shelter, name: 'Best Test Shelter') }
  let!(:pet1) { create(:pet, name: 'Edna', approximate_age: 6, sex: 'Female', shelter_id: shelter.id) }
  let!(:pet2) { create(:pet, name: 'Tayla', approximate_age: 2, sex: 'Female', shelter_id: shelter.id) }

  before do
    visit "/shelters/#{shelter.id}/pets"
  end

  it 'can see title' do
    expect(page).to have_content("These animals from #{shelter.name} are looking for a loving home!")
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

  it 'can see all pets at a shelter' do
    expect(page).to have_link(pet1.name)
    expect(page).to have_content(pet1.approximate_age)
    expect(page).to have_content(pet1.sex)

    expect(page).to have_link(pet2.name)
    expect(page).to have_content(pet2.approximate_age)
    expect(page).to have_content(pet2.sex)
  end

  it 'can see link to create new pet' do
    expect(page).to have_link('Create Pet')

    click_link 'Create Pet'
    expect(page).to have_current_path("/shelters/#{shelter.id}/pets/new")

    expect(page).to have_content('Add a New Adoptable Pet')
    expect(page.has_field?(:name)).to eq(true)
    expect(page.has_field?(:image)).to eq(true)
    expect(page.has_field?(:description)).to eq(true)
    expect(page.has_field?(:approximate_age)).to eq(true)
    expect(page.has_field?(:sex)).to eq(true)
  end
end
