require 'rails_helper'

RSpec.describe '/users/new', type: :feature do
  describe 'form submission' do
    it 'can add user' do
      visit users_new_path

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
  end
end
