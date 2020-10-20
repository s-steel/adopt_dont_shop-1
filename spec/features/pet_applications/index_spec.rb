require 'rails_helper'

RSpec.describe '/pets/:id/pet_application', type: :feature do
  describe 'page layout' do
    it 'has content' do
      application1 = create(:user_application)
      application2 = create(:user_application)
      pet1 = create(:pet)
      pet2 = create(:pet)
      pet3 = create(:pet)

      create(:application_pet, user_application_id: application1.id, pet_id: pet1.id)
      create(:application_pet, user_application_id: application1.id, pet_id: pet2.id)
      create(:application_pet, user_application_id: application2.id, pet_id: pet2.id)

      visit "/pets/#{pet2.id}/pet_applications"
      expect(page).to have_content('List of Applicants')
      expect(page).to have_link(application1.user_name)
      expect(page).to have_link(application2.user_name)

      visit "/pets/#{pet3.id}/pet_applications"
      expect(page).to have_content('There are no applications for this pet yet.')

    end
  end
end
