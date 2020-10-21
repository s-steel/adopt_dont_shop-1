require 'rails_helper'

describe 'pet show page' do
  let(:pet) { create(:pet, name: 'Taylor', approximate_age: 6, sex: 'Male', description: 'Old')}

  before do
    visit "/pets/#{pet.id}"
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

  it 'can see pet information' do
    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.description)
    expect(page).to have_content(pet.approximate_age)
    expect(page).to have_content(pet.sex)
    expect(page).to have_content(pet.status)
  end

  it 'can update pet information' do
    expect(page).to have_link('Update Information')

    click_link 'Update Information'
    expect(page).to have_current_path("/pets/#{pet.id}/edit")

    expect(page).to have_content("Edit #{pet.name}'s Information")
    expect(page.has_field?(:name, with: pet.name)).to eq(true)
    expect(page.has_field?(:image, with: pet.image)).to eq(true)
    expect(page.has_field?(:description, with: pet.description)).to eq(true)
    expect(page.has_field?(:approximate_age, with: pet.approximate_age)).to eq(true)
    expect(page.has_field?(:sex, with: pet.sex)).to eq(true)

    fill_in :name, with: 'Julia'
    fill_in :image, with: 'none'
    fill_in :description, with: 'v v cute'
    fill_in :approximate_age, with: 2
    fill_in :sex, with: 'Female'

    click_button 'Update Pet'
    expect(page).to have_current_path("/pets/#{pet.id}")

    expect(page).to have_content('Julia')
    expect(page).to have_content('v v cute')
    expect(page).to have_content('2')
    expect(page).to have_content('Female')
    expect(page).to have_content('Adoptable')
  end

  it 'can delete pet' do
    expect(page).to have_button('Delete Pet')

    click_button 'Delete Pet'
    expect(page).to have_current_path('/pets')
  end

  it 'cannot delete pets with approved applications' do
    application1 = create(:user_application)
    create(:application_pet, user_application: application1, pet: pet)
    visit "/admin/applications/#{application1.id}"
    click_button "Approve #{pet.name}"
    visit "/pets/#{pet.id}"
    expect(page).to_not have_button('Delete Pet')
  end
end
