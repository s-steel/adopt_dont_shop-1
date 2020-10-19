require 'rails_helper'

RSpec.describe '/applications/new', type: :feature do
  describe 'page layout' do
    it 'has content' do
      visit applications_new_path

      expect(page).to have_content('Fill Out Your Application')
      expect(page.has_field?(:username, type: 'text')).to eq(true)
      expect(page).to have_button('Submit')
    end
  end

  describe 'form submission' do
    context 'when the user is a valid user' do
      it 'can submit a form' do
        user = create(:user)

        visit applications_new_path
        fill_in :username, with: user.name
        click_button 'Submit'
        application = UserApplication.last

        expect(page).to have_current_path("/applications/#{application.id}")
      end
    end

    context 'when the user is not a valid user' do
      it 'can not submit a form' do
        visit applications_new_path
        fill_in :username, with: 'John'
        click_button 'Submit'

        expect(page).to have_current_path(applications_new_path)
        expect(page).to have_content('ERROR: User could not be found')
      end
    end
  end
end
