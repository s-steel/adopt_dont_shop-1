FactoryBot.define do
  factory :pet do
    name { Faker::Name.middle_name }
    image { 'none' }

    shelter
  end
end
