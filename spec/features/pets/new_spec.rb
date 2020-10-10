require 'rails_helper'

describe 'pet creation page' do
  let(:shelter) { create(:shelter, name: 'Best Test Shelter') }

  before do
    visit "/shelters/#{shelter.id}/pets/new"
  end

  it 'can see title' do
    expect(page).to have_content('Add a New Adoptable Pet')
  end

  it 'can see form' do
    expect(page.has_field?(:name)).to eq(true)
    expect(page.has_field?(:image)).to eq(true)
    expect(page.has_field?(:description)).to eq(true)
    expect(page.has_field?(:approximate_age)).to eq(true)
    expect(page.has_field?(:sex)).to eq(true)
  end

  it 'can fill out a new pet form' do
    fill_in :name, with: 'Edna'
    fill_in :image, with: 'none'
    fill_in :description, with: 'very cute'
    fill_in :approximate_age, with: 8
    fill_in :sex, with: 'Female'

    click_button 'Add Pet'
    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")

    expect(page).to have_link('Edna')
    expect(page).to have_content('8')
    expect(page).to have_content('Female')
  end
end
