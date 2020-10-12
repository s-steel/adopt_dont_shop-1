require 'rails_helper'

describe 'User show page' do
  it 'see all user info' do
    let(:user) do
      create(:user,
              name: 'Bob Bobby',
              address: '123 Main St',
              city: 'Denver',
              state: 'CO',
              zip: 84361)
    end
  end
end
