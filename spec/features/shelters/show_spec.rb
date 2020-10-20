require 'rails_helper'

describe 'shelter show page' do
  let!(:shelter) do
    create(
      :shelter,
      name: 'Test Shelter 1',
      address: '1 Test St.',
      city: 'Denver',
      state: 'CO',
      zip: 12346
    )
  end

  let!(:user) { create(:user, name: 'Jim Jones') }
  let!(:review) { create(:review, title: 'Great!', rating: 5,
          content: 'Really good', shelter_id: shelter.id, user_id: user.id) }

  before do
    visit "shelters/#{shelter.id}"
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

  it 'can see shelter information' do
    expect(page).to have_content(shelter.name.to_s)
    expect(page).to have_content(shelter.address.to_s)
    expect(page).to have_content(shelter.city.to_s)
    expect(page).to have_content(shelter.state.to_s)
    expect(page).to have_content(shelter.zip.to_s)
  end

  it 'can see all pets a shelter link' do
    expect(page).to have_link("See All Pets at #{shelter.name}")
    click_link("See All Pets at #{shelter.name}")
    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")
  end

  it 'can see reviews' do
    expect(page).to have_content('Reviews')
    expect(page).to have_content(review.title)
    expect(page).to have_content(review.rating)
    expect(page).to have_content(review.content)
    expect(page).to have_content(user.name)
  end

  it 'can see update shelter link' do
    expect(page).to have_link('Update Shelter')
  end

  it 'can delete a shelter' do
    expect(page).to have_button('Delete Shelter')

    click_button 'Delete Shelter'
    expect(page).to have_current_path('/shelters')
  end

  it 'can delete a review' do
    expect(page).to have_button('Delete Review')

    click_button 'Delete Review'
    expect(page).to have_current_path("/shelters/#{shelter.id}")

    expect(page).to_not have_content(review.title)
    expect(page).to_not have_content(review.rating)
    expect(page).to_not have_content(review.content)
    expect(page).to_not have_content(user.name)
  end

  it 'can see shelter statistics' do
    expect(page).to have_content('Average Review:')
    expect(page).to have_content('Number of Pets at this Shelter:')
    expect(page).to have_content('Number of Applications on File:')
    expect(shelter.average_review_rating).to eq(5)
    # expect(shelter.pet_count).to eq(3.5)
    # expect(shelter.number_applications).to eq(3.5)

  end

  it 'cannot delete a shelter with approved pet applications' do
    expect(page).to_not have_content('Delete Shelter')
  end
end
