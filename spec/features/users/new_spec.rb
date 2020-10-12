require 'rails_helper'

describe 'User show page' do
  let(:user) do
    create(:user,
            name: 'Bob Bobby',
            address: '123 Main St',
            city: 'Denver',
            state: 'CO',
            zip: 84361)
  end

  before do
    visit "/users/new"
  end

  it 'fill in form for new user' do
binding.pry
    fill_in :name, with: 'Ned Smith'
    fill_in :address, with: '78 Greenwood Ln.'
    fill_in :city, with: 'Brentwood'
    fill_in :state, with: 'TN'
    fill_in :zip, with: '37218'

    click_button 'Add User'
    expect(page).to have_current_path("/users/#{user.id}")
    expect(page).to have_content('Ned Smith')
    expect(page).to have_content('78 Greenwood Ln.')
    expect(page).to have_content('Brentwood')
    expect(page).to have_content('TN')
    expect(page).to have_content('37218')
  end
end
