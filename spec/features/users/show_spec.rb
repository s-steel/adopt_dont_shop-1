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
end