require 'rails_helper'

describe 'application show page' do
  let!(:shelter1) { create(:shelter, name: 'Best Test Shelter') }
  let!(:user) { create(:user, name: 'Rick', address: '1 st.', city: 'Denver', state: 'CO', zip: 12244) }
  let!(:user_application) { create(:user_application, description: nil, status: "In Progress", user_id: user.id)  }

  before do
    visit "/applications/#{user_application.id}"
  end

  it 'show application with no pets' do
    expect(page).to have_content("Application #{user_application.id}")
    expect(page).to have_content("Application Status")
    expect(page).to have_content(user_application.status)
    expect(page).to have_content(user_application.user_name)
    expect(page).to have_content(user_application.user_address)
    expect(page).to have_content(user_application.user_city)
    expect(page).to have_content(user_application.user_state)
    expect(page).to have_content(user_application.user_zip)
    expect(page).to_not have_content("Description")
    expect(page).to have_content("Pets")
    expect(page).to have_content("Add Pets to Application")
    expect(page).to have_button("Search")
  end

  let!(:pet1) { create(:pet, name: 'Edna', approximate_age: 6, sex: 'Female', shelter_id: shelter1.id) }
  let!(:pet2) { create(:pet, name: 'Sean', approximate_age: 12, sex: 'Male', shelter_id: shelter1.id) }
  let!(:pet3) { create(:pet, name: 'Taylor', approximate_age: 1, sex: 'Female', shelter_id: shelter1.id) }

  it 'add pets to application' do
    expect(page).to have_content("Add Pets to Application")
    fill_in :search, with: pet1.name
    click_button 'Search'
    expect(page).to have_content(pet1.name)
    expect(page).to have_button("Adopt #{pet1.name}")
    click_button "Adopt #{pet1.name}"
    expect(page).to have_link(pet1.name)
  end

  let!(:application_pet1) { create(:application_pet, user_application_id: user_application.id, pet_id: pet1.id) }
  let!(:application_pet2) { create(:application_pet, user_application_id: user_application.id, pet_id: pet2.id) }

  it 'shows submitted application' do
    fill_in :search, with: pet1.name
    click_button 'Search'
    expect(page).to have_content(pet1.name)
    expect(page).to have_button("Adopt #{pet1.name}")
    click_button "Adopt #{pet1.name}"
    expect(page).to have_content('Why would you make a good pet owner?')
    expect(page).to have_button('Submit Application')
    expect(page).to have_field(:description)
    click_button 'Submit Application'
    expect(page).to have_content('ERROR: You must fill out why you would be a good pet owner')
    fill_in :description, with: 'I like pets'
    click_button 'Submit Application'
    expect(page).to have_content("Application #{user_application.id}")
    expect(page).to have_content("Application Status")
    expect(user_application.status).to eq('Pending')
    expect(page).to have_content(user_application.status)
    expect(page).to have_content(user_application.user_name)
    expect(page).to have_content(user_application.user_address)
    expect(page).to have_content(user_application.user_city)
    expect(page).to have_content(user_application.user_state)
    expect(page).to have_content(user_application.user_zip)
    expect(page).to have_content("Description")
    expect(page).to have_content(user_application.description)
    expect(page).to have_content("Pets")
    expect(page).to have_link(pet1.name)
  end
end
