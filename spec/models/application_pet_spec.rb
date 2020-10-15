require 'rails_helper'

describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to :user_application }
    it { should belong_to :pet }
  end
end
