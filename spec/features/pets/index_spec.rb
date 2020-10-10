require 'rails_helper'

describe 'pet index page' do
  let!(:shelter1) { create(:shelter, name: 'Great Test Shelter') }
  let!(:shelter2) { create(:shelter, name: 'Cool Test Shelter') }
  let!(:pet1) { create(:pet, name: 'Taylor', approximate_age: 6, sex: 'Male', shelter_id: shelter1.id) }
  let!(:pet2) { create(:pet, name: 'Edna', approximate_age: 8, sex: 'Female', shelter_id: shelter2.id) }

  before do
    visit '/pets'
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

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter2.name)
  end
end
