require 'rails_helper'

RSpec.describe 'users/:id', type: :feature do
  describe 'page layout' do
    context 'user information' do
      it 'can see all user information' do
        user = create(:user)

        visit "users/#{user.id}"
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.address)
        expect(page).to have_content(user.city)
        expect(page).to have_content(user.state)
        expect(page).to have_content(user.zip)
      end
    end

    context 'when user has written reviews' do
      before do
        @user = create(:user)
        @review1 = create(:review, rating: 1, user: @user)
        @review2 = create(:review, rating: 2, user: @user)
        @review3 = create(:review, rating: 5, user: @user)
        visit "users/#{@user.id}"
      end

      it 'can see average rating' do
        expect(page).to have_content("#{@user.name}'s Average Review Rating")
        expect(page).to have_content("2.7 / 5")
      end

      it 'can see highest rated review' do
        within('#highlighted-reviews') do
          expect(page).to have_content("Highlighted Reviews")
          expect(page).to have_content("#{@user.name}'s Highest Rated Review")
          expect(page).to have_content(@review3.title)
          expect(page).to have_content(@review3.rating)
          expect(page).to have_content(@review3.content)
        end
      end

      it 'can see lowest rated review' do
        within('#highlighted-reviews') do
          expect(page).to have_content("Highlighted Reviews")
          expect(page).to have_content("#{@user.name}'s Worst Rated Review")
          expect(page).to have_content(@review1.title)
          expect(page).to have_content(@review1.rating)
          expect(page).to have_content(@review1.content)
        end
      end

      it 'can see all reviews' do
        expect(page).to have_content("#{@user.name}'s Reviews")
        expect(page).to have_content(@review1.title)
        expect(page).to have_content(@review1.rating)
        expect(page).to have_content(@review1.content)
        expect(page).to have_content(@review2.title)
        expect(page).to have_content(@review2.rating)
        expect(page).to have_content(@review2.content)
        expect(page).to have_content(@review3.title)
        expect(page).to have_content(@review3.rating)
        expect(page).to have_content(@review3.content)
      end
    end

    context 'when user has no reviews' do
      it 'can see no reviews message' do
        user = create(:user)
        
        visit "/users/#{user.id}"
        expect(page).to have_content("User has no reviews yet")
      end
    end
  end
end
