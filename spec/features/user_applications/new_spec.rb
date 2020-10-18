require 'rails_helper'

describe 'application new page' do
  let!(:user) { create(:user, name: 'Rick', address: '1 st.', city: 'Denver', state: 'CO', zip: 12244) }

  before do
    visit "/applications/new"
  end

  it 'new application page' do
    expect(page).to have_content("Fill Out Your Application")
    expect(page.has_field?(:username, type: 'text')).to eq(true)
    expect(page).to have_button('Submit')
  end

  it 'fill out form and submit' do
    fill_in :username, with: 'Rick'
    click_button 'Submit'
    app_new = UserApplication.last

    expect(page).to have_current_path("/applications/#{app_new.id}")

    expect(page).to have_content("Application #{app_new.id}")
    expect(page).to have_content("Application Status")
    expect(page).to have_content(app_new.status)
    expect(page).to have_content(app_new.user_name)
    expect(page).to have_content(app_new.user_address)
    expect(page).to have_content(app_new.user_city)
    expect(page).to have_content(app_new.user_state)
    expect(page).to have_content(app_new.user_zip)
    expect(page).to have_content("Pets")
  end

  it 'must be a user to submit an application' do
    fill_in :username, with: 'John'

    click_button 'Submit'
    expect(page).to have_current_path("/applications/new")
    expect(page).to have_content('ERROR: User could not be found')
  end
end
