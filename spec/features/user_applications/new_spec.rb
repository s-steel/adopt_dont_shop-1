require 'rails_helper'

describe 'application new page' do
  # let!(:shelter1) { create(:shelter, name: 'Best Test Shelter') }
  let!(:user) { create(:user, name: 'Rick', address: '1 st.', city: 'Denver', state: 'CO', zip: 12244) }
  #
  # let!(:pet1) { create(:pet, name: 'Edna', approximate_age: 6, sex: 'Female', shelter_id: shelter1.id) }
  # let!(:pet2) { create(:pet, name: 'Sean', approximate_age: 12, sex: 'Male', shelter_id: shelter1.id) }
  # let!(:pet3) { create(:pet, name: 'Taylor', approximate_age: 1, sex: 'Female', shelter_id: shelter1.id) }
  #
  # let!(:user_application) { create(:user_application, description: "I'd love to Adopt!", status: "Pending", user_id: user.id)  }
  # let!(:application_pet1) { create(:application_pet, user_application_id: user_application.id, pet_id: pet1.id) }
  # let!(:application_pet2) { create(:application_pet, user_application_id: user_application.id, pet_id: pet2.id) }

  before do
    visit "/applications/new"
  end

  it 'new application page' do
    expect(page).to have_content("Fill Out Your Application")
    expect(page.has_field?(:username, type: 'text')).to eq(true)
    expect(page.has_field?(:description, type: 'textarea')).to eq(true)
    expect(page).to have_button('Submit')
  end

  it 'fill out form and submit' do
    fill_in :username, with: 'Rick'
    fill_in :description, with: 'Doggie Now'
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
    expect(page).to have_content("Description")
    expect(page).to have_content(app_new.description)
    expect(page).to have_content("Pets")
  end
end
