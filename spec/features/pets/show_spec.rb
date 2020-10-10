require 'rails_helper'

describe 'pet show page' do
  let(:shelter) { create(:shelter, name: 'Best Test Shelter') }
  let(:pet) { create(:pet, name: 'Edna', approximate_age: 6, sex: 'Female', shelter_id: shelter.id) }

  before do
    visit "/pets/#{pet.id}"
  end

  it 'can see pet information' do
    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.description)
    expect(page).to have_content(pet.approximate_age)
    expect(page).to have_content(pet.sex)
    expect(page).to have_content(pet.status)
  end

  it 'can link to update pet information' do
    expect(page).to have_link('Update Information')

    click_link 'Update Information'
    expect(page).to have_content("Edit #{pet.name}'s Information")
    expect(page.has_field?(:name, with: pet.name)).to eq(true)
    expect(page.has_field?(:image, with: pet.image)).to eq(true)
    expect(page.has_field?(:description, with: pet.description)).to eq(true)
    expect(page.has_field?(:approximate_age, with: pet.approximate_age)).to eq(true)
    expect(page.has_field?(:sex, with: pet.sex)).to eq(true)
  end
end
