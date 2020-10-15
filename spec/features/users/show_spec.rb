require 'rails_helper'

describe 'User show page' do
  let!(:shelter) { create(:shelter, name: 'Best Test Shelter') }
  let!(:user1) do
    create(:user,
            name: 'Bob Bobby',
            address: '123 Main St',
            city: 'Denver',
            state: 'CO',
            zip: 84361)
  end
  let!(:user2) do
    create(:user,
            name: 'Nick',
            address: '123 South St',
            city: 'Buena Vista',
            state: 'CO',
            zip: 84353)
  end
  let!(:review1) { create(:review, title: 'Test', rating: 1, content: 'Terrible', user_id: user1.id, shelter_id: shelter.id)}
  let!(:review2) { create(:review, title: 'Test Two', rating: 4, content: 'Great!', user_id: user1.id, shelter_id: shelter.id)}

  before do
    visit "/users/#{user1.id}"
  end

  it 'see all user info' do
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user1.address)
    expect(page).to have_content(user1.city)
    expect(page).to have_content(user1.state)
    expect(page).to have_content(user1.zip)
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

  it 'can see average rating' do
    expect(page).to have_content("#{user1.name}'s Average Review Rating")
    expect(page).to have_content("2.5 / 5")
  end

  it 'can see all reviews' do
    expect(page).to have_content("#{user1.name}'s Reviews")
    expect(page).to have_content(review1.title)
    expect(page).to have_content(review1.rating)
    expect(page).to have_content(review1.content)
    expect(page).to have_content(review2.title)
    expect(page).to have_content(review2.rating)
    expect(page).to have_content(review2.content)
  end

  it 'see highlighted reviews' do
    within('#highlighted-reviews') do
      expect(page).to have_content("Highlighted Reviews")
      expect(page).to have_content("#{user1.name}'s Highest Rated Review")
      expect(page).to have_content("#{user1.name}'s Worst Rated Review")
      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.content)
      expect(page).to have_content(review2.title)
      expect(page).to have_content(review2.rating)
      expect(page).to have_content(review2.content)
    end
  end

  it 'see when user has no reviews' do
    visit "/users/#{user2.id}"
    expect(page).to have_content("User has no reviews yet")
  end

end
