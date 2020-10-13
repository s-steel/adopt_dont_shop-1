require 'rails_helper'

describe 'pet show page' do
  let(:shelter) { create(:shelter, name: 'Best Test Shelter') }
  let!(:user) { create(:user, name: 'Rick')}
  let!(:review) { create(:review, title: 'Great!', rating: 5,
          content: 'Really good', shelter_id: shelter.id, user_id: user.id) }

  before do
    visit "/shelters/#{shelter.id}/reviews/#{review.id}/edit"
  end

  it 'can update pet information' do
    expect(page).to have_content("Edit Your Review")
    expect(page.has_field?(:title, with: review.title)).to eq(true)
    expect(page.has_field?(:rating, with: review.rating)).to eq(true)
    expect(page.has_field?(:content, with: review.content)).to eq(true)
    expect(page.has_field?(:username, with: user.name)).to eq(true)

    fill_in :title, with: 'Test'
    fill_in :rating, with: 4
    fill_in :content, with: 'Great'
    fill_in :username, with: user.name

    click_button 'Edit Review'
    expect(page).to have_current_path("/shelters/#{shelter.id}")

    expect(page).to have_content('Test')
    expect(page).to have_content('4')
    expect(page).to have_content('Great')
    expect(page).to have_content(user.name)
  end
end
