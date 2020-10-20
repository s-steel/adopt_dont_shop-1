require 'rails_helper'

RSpec.describe 'applications/:id', type: :feature do
  describe 'general layout' do
    before do
      @application = create(:user_application)
      visit "applications/#{@application.id}"
    end

    it 'has headers' do
      expect(page).to have_content("Application #{@application.id}")
      expect(page).to have_content("Application Status")
      expect(page).to have_content(@application.status)
      expect(page).to have_content("Pets")
    end

    it 'has user information' do
      expect(page).to have_content(@application.user_name)
      expect(page).to have_content(@application.user_address)
      expect(page).to have_content(@application.user_city)
      expect(page).to have_content(@application.user_state)
      expect(page).to have_content(@application.user_zip)
    end
  end

  describe 'functionality' do
    context 'when an application is new' do
      before do
        @application = create(:user_application)
        visit "applications/#{@application.id}"
      end

      it 'has search bar and button' do
        expect(page).to have_field(:search)
        expect(page).to have_button("Search")
      end

      it 'can search for a pet name' do
        pet = create(:pet)
        fill_in :search, with: pet.name
        click_button 'Search'

        expect(page).to have_link(pet.name)
        expect(page).to have_button("Adopt #{pet.name}")
      end

      it 'can search for a partial pet name' do
        pet = create(:pet, name: 'Wesley')
        fill_in :search, with: 'wes'
        click_button 'Search'

        expect(page).to have_link(pet.name)
        expect(page).to have_button("Adopt #{pet.name}")
      end

      it 'can add a searched for pet to the application' do
        pet = create(:pet)
        fill_in :search, with: pet.name
        click_button 'Search'

        expect(page).to have_link(pet.name)
        expect(page).to have_button("Adopt #{pet.name}")

        click_button "Adopt #{pet.name}"
        expect(page).to have_link(pet.name)
      end
    end

    context 'when an application is able to be submitted' do
      before do
        @application = create(:user_application, :with_pets, pet_count: 3)
        visit "/applications/#{@application.id}"
      end

      it 'is still in progress' do
        expect(@application.status).to eq('In Progress')
      end

      it 'has pets' do
        expect(@application.pets).to_not be_empty
      end

      it 'has submit application content' do
        expect(page).to have_content('Why would you make a good pet owner?')
        expect(page).to have_field(:description)
        expect(page).to have_button('Submit Application')
      end
    end

    context 'when a user submits and application' do
      before do
        @application = create(:user_application, :with_pets, pet_count: 3)
        visit "/applications/#{@application.id}"
      end

      it 'must answer why they would be a good owner' do
        click_button 'Submit Application'

        expect(page).to have_current_path("/applications/#{@application.id}")
        expect(page).to have_content('ERROR: You must fill out why you would be a good pet owner')
      end

      xit 'can see pending application content' do
        fill_in :description, with: 'I like pets'
        click_button 'Submit Application'

        expect(page).to have_current_path("/applications/#{@application.id}")
        expect(@application.status).to eq('Pending')
      end
    end

    context 'when a user is an admin' do
      before do
        @application = create(:user_application, :with_pets, pet_count: 3)
        visit "/admin/applications/#{@application.id}"
      end

      it 'can approve pets' do
        expect(page).to have_button("Approve #{@application.pets[0].name}")
        click_button "Approve #{@application.pets[0].name}"
        expect(page).to have_current_path("/admin/applications/#{@application.id}")

        within '#pet-approved' do
          expect(page).to have_content("#{@application.pets[0].name} Approved")
        end
      end

      it 'can reject pets' do
        expect(page).to have_button("Reject #{@application.pets[0].name}")
        click_button "Reject #{@application.pets[0].name}"
        expect(page).to have_current_path("/admin/applications/#{@application.id}")

        within '#pet-rejected' do
          expect(page).to have_content("#{@application.pets[0].name} Rejected")
        end
      end

      it 'approves application when all pets are approved' do
        click_button "Approve #{@application.pets[0].name}"
        click_button "Approve #{@application.pets[1].name}"
        click_button "Approve #{@application.pets[2].name}"
        expect(page).to have_current_path("/admin/applications/#{@application.id}")

        within '#application-status' do
          expect(page).to have_content('Approved')
        end
      end

      it 'rejects application when a pet has been rejected' do
        click_button "Approve #{@application.pets[0].name}"
        click_button "Reject #{@application.pets[1].name}"
        click_button "Approve #{@application.pets[2].name}"
        expect(page).to have_current_path("/admin/applications/#{@application.id}")

        within '#application-status' do
          expect(page).to have_content('Rejected')
        end
      end

      it 'can see if pet has an aprroved application on them' do
        application1 = create(:user_application)
        application2 = create(:user_application)
        pet1 = create(:pet)
        pet2 = create(:pet)
        pet3 = create(:pet)

        create(:application_pet, user_application_id: application1.id, pet_id: pet1.id)
        create(:application_pet, user_application_id: application1.id, pet_id: pet2.id)
        create(:application_pet, user_application_id: application1.id, pet_id: pet3.id)
        create(:application_pet, user_application_id: application2.id, pet_id: pet3.id)

        visit "/admin/applications/#{application1.id}"
        click_button "Approve #{application1.pets[0].name}"
        click_button "Approve #{application1.pets[1].name}"
        click_button "Approve #{application1.pets[2].name}"

        visit "/admin/applications/#{application2.id}"
        expect(page).to have_content("We're sorry. #{pet3.name} has an approved application on them") 
      end
    end
  end
end

#     expect(page).to have_content("Application #{user_application.id}")
#     expect(page).to have_content("Application Status")
#     expect(user_application.status).to eq('Pending')
#     expect(page).to have_content(user_application.status)
#     expect(page).to have_content(user_application.user_name)
#     expect(page).to have_content(user_application.user_address)
#     expect(page).to have_content(user_application.user_city)
#     expect(page).to have_content(user_application.user_state)
#     expect(page).to have_content(user_application.user_zip)
#     expect(page).to have_content("Description")
#     expect(page).to have_content(user_application.description)
#     expect(page).to have_content("Pets")
#     expect(page).to have_link(pet1.name)
#   end
# end
