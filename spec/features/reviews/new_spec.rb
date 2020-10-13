require 'rails_helper'

describe 'review new page' do
    let!(:shelter) { create(:shelter, name: 'Best Test Shelter') }
    let!(:user) { create(:user, name: 'Rick')}

  before do
    visit "/shelters/#{shelter.id}/reviews/new"
  end

  it 'can see title' do
    expect(page).to have_content('Add a New Review')
  end

  it 'can see form' do
    expect(page.has_field?(:title, type: 'text')).to eq(true)
    expect(page.has_field?(:rating, type: 'text')).to eq(true)
    expect(page.has_field?(:content, type: 'textarea')).to eq(true)
    expect(page.has_field?(:image, type: 'text')).to eq(true)
    expect(page.has_field?(:username, type: 'text')).to eq(true)
  end

  it 'can fill out a new review form' do

    fill_in :title, with: 'Test'
    fill_in :rating, with: 3
    fill_in :content, with: 'Great'
    fill_in :username, with: 'Rick'

    click_button 'Add Review'
    expect(page).to have_current_path("/shelters/#{shelter.id}")
    expect(page).to have_content('Best Test Shelter')

    expect(page).to have_content('Test')
    expect(page).to have_content(3)
    expect(page).to have_content('Great')
    expect(page).to have_content('Rick')
  end
end
