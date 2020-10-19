FactoryBot.define do
  factory :shelter do
    name { Faker::Company.name + " Shelter" }
  end
end
