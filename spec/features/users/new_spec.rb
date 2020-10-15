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
  let!(:review1) { create(:review, title: 'Test', rating: 1, content: 'Terrible', user_id: user.id, shelter_id: shelter.id)}
  let!(:review2) { create(:review, title: 'Test Two', rating: 4, content: 'Great!', user_id: user.id, shelter_id: shelter.id)}

  before do
    visit "/users/new"
  end

  it 'fill in form for new user' do
    fill_in :name, with: 'Ned Smith'
    fill_in :address, with: '78 Greenwood Ln.'
    fill_in :city, with: 'Brentwood'
    fill_in :state, with: 'TN'
    fill_in :zip, with: '37218'
    
    click_button 'Add User'
    user_new = User.last

    expect(page).to have_current_path("/users/#{user_new.id}")
    expect(page).to have_content('Ned Smith')
    expect(page).to have_content('78 Greenwood Ln.')
    expect(page).to have_content('Brentwood')
    expect(page).to have_content('TN')
    expect(page).to have_content('37218')
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
end
