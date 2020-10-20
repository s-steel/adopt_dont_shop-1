require 'rails_helper'

RSpec.describe '/sheleters/:id', type: :feature do
  describe 'general layout' do
    before do
      @shelter = create(:shelter)
      visit "/shelters/#{@shelter.id}"
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

    it 'can see shelter information' do
      expect(page).to have_content(@shelter.name.to_s)
      expect(page).to have_content(@shelter.address.to_s)
      expect(page).to have_content(@shelter.city.to_s)
      expect(page).to have_content(@shelter.state.to_s)
      expect(page).to have_content(@shelter.zip.to_s)
    end

    it 'can see all pets a shelter link' do
      expect(page).to have_link("See All Pets at #{@shelter.name}")
      click_link("See All Pets at #{@shelter.name}")
      expect(page).to have_current_path("/shelters/#{@shelter.id}/pets")
    end

    it 'can see update shelter link' do
      expect(page).to have_link('Update Shelter')
    end
  end

  describe 'functionality' do
    context 'when a shelter has reviews' do
      it 'can see reviews' do
        shelter = create(:shelter, :with_reviews)

        visit "/shelters/#{shelter.id}"
        expect(page).to have_content('Reviews')
        expect(page).to have_content(shelter.reviews[0].title)
        expect(page).to have_content(shelter.reviews[0].rating)
        expect(page).to have_content(shelter.reviews[0].content)
        expect(page).to have_content(shelter.reviews[0].user.name)
      end

      it 'can delete a review' do
       shelter = create(:shelter, :with_reviews, review_count: 1)

        visit "/shelters/#{shelter.id}"
        expect(page).to have_button('Delete Review')
        click_button 'Delete Review'
        expect(page).to have_current_path("/shelters/#{shelter.id}")

        expect(page).to_not have_content(shelter.reviews[0].title)
        expect(page).to_not have_content(shelter.reviews[0].rating)
        expect(page).to_not have_content(shelter.reviews[0].content)
        expect(page).to_not have_content(shelter.reviews[0].user.name)
      end
    end

    context 'shelter statistics' do
      it 'can see average review rating'do
        shelter = create(:shelter)
        review1 = create(:review, rating: 1, shelter: shelter)
        review2 = create(:review, rating: 2, shelter: shelter)
        review3 = create(:review, rating: 5, shelter: shelter)

        visit "/shelters/#{shelter.id}"
        expect(page).to have_content('Average Review:')
        expect(shelter.average_review_rating.round(1)).to eq(2.7)
      end

      it 'can see number of pets at the shelter' do
        shelter = create(:shelter, :with_pets, pet_count: 3) 

        visit "/shelters/#{shelter.id}"
        expect(page).to have_content('Number of Pets at this Shelter:')
        expect(shelter.pet_count).to eq(3)
      end

      it 'can see the total number of applications for pets at shelter' do
        shelter = create(:shelter, :with_pets, pet_count: 3) 

        create(:application_pet, pet: shelter.pets[0]) 
        create(:application_pet, pet: shelter.pets[1]) 
        create(:application_pet, pet: shelter.pets[2]) 
        create(:application_pet, pet: shelter.pets[2]) 

        visit "/shelters/#{shelter.id}"
        expect(page).to have_content('Number of Applications on File:')
        expect(shelter.number_applications).to eq(4)
      end
    end 

    context 'shelter deletion constraints' do
      it 'can not delete shelter with approved applications for pets' do
        shelter = create(:shelter, :with_pets, pet_count: 3) 

        application1 = create(:user_application) 
        application2 = create(:user_application) 

        create(:application_pet, user_application: application1, pet: shelter.pets[0]) 
        create(:application_pet, user_application: application1, pet: shelter.pets[1]) 
        create(:application_pet, user_application: application1, pet: shelter.pets[2]) 
        create(:application_pet, user_application: application2, pet: shelter.pets[2]) 

        visit "/shelters/#{shelter.id}"
        expect(page).to have_button('Delete Shelter') 

        visit "/admin/applications/#{application2.id}"
        click_button "Approve #{shelter.pets[2].name}"

        visit "/shelters/#{shelter.id}"
        expect(page).to_not have_button('Delete Shelter') 
      end

      it 'can not delete shelter with approved applications for pets' do
        shelter = create(:shelter, :with_pets, pet_count: 3) 

        visit "/shelters/#{shelter.id}"
        expect(page).to have_button('Delete Shelter') 
        click_button 'Delete Shelter'
      end
    end
  end
end
