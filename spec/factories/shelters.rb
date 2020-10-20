FactoryBot.define do
  factory :shelter do
    name { Faker::Company.name + " Shelter" }

    trait :with_reviews do
      transient do
        review_count { 3 }
      end

      after(:create) do |shelter, evaluator|
        shelter.reviews << create_list(:review, evaluator.review_count)
      end
    end

    trait :with_pets do
      transient do
        pet_count { 3 }
      end

      after(:create) do |shelter, evaluator|
        shelter.pets << create_list(:pet, evaluator.pet_count)
      end
    end
  end
end
