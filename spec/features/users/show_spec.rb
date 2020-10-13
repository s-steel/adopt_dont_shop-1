require 'rails_helper'

describe 'User show page' do
  let!(:shelter) { create(:shelter, name: 'Best Test Shelter') }
  let!(:user) do
    create(:user,
            name: 'Bob Bobby',
            address: '123 Main St',
            city: 'Denver',
            state: 'CO',
            zip: 84361)
  end
  let!(:review) { create(:review, title: 'Test', rating: 3, content: 'Terrible', user_id: user.id, shelter_id: shelter.id)}

  before do
    visit "/users/#{user.id}"
  end

  it 'see all user info' do
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.address)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.state)
    expect(page).to have_content(user.zip)
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

  it 'can see all reviews' do
    expect(page).to have_content("#{user.name}'s Reviews")
    expect(page).to have_content(review.title)
    expect(page).to have_content(review.rating)
    expect(page).to have_content(review.content)
  end
end
