require 'rails_helper'

describe 'pet index page' do
  let!(:shelter1) { create(:shelter, name: 'Great Test Shelter') }
  let!(:shelter2) { create(:shelter, name: 'Cool Test Shelter') }
  let!(:pet1) { create(:pet, name: 'Taylor', approximate_age: 6, sex: 'Male', shelter_id: shelter1.id) }
  let!(:pet2) { create(:pet, name: 'Edna', approximate_age: 8, sex: 'Female', shelter_id: shelter2.id) }

  before do
    visit '/pets'
  end

  it 'can see shelters index link' do
    expect(page).to have_link('Shelters Index')
    click_link('Shelters Index')
    expect(page).to have_current_path('/shelters')
  end

  it 'can see title' do
    expect(page).to have_content('All Pets')
  end

  it 'can see pets' do
    expect(page).to have_link(pet1.name)
    expect(page).to have_link(pet2.name)

    expect(page).to have_content(pet1.approximate_age)
    expect(page).to have_content(pet2.approximate_age)

    expect(page).to have_content(pet1.sex)
    expect(page).to have_content(pet2.sex)

    expect(page).to have_link(shelter1.name)
    expect(page).to have_link(shelter2.name)
  end

  it 'can link to pets shelter' do
    expect(page).to have_link(shelter1.name)

    click_link(shelter1.name)
    expect(page).to have_current_path("/shelters/#{shelter1.id}")
  end

  it 'can link to update pet' do
    expect(page).to have_link("Update #{pet1.name}'s Information")

    click_link ("Update #{pet1.name}'s Information")
    expect(page).to have_current_path("/pets/#{pet1.id}/edit")
  end

  it 'can delete pet' do
    expect(page).to have_button("Delete #{pet1.name}")

    click_button("Delete #{pet1.name}")
    expect(page).to have_current_path('/pets')
  end
end
