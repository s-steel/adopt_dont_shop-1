FactoryBot.define do
  factory :user_application do
    user

    trait :with_pets do
      transient do
        pet_count { 3 }
      end

      after(:create) do |user_application, evaluator|
        user_application.pets << create_list(:pet, evaluator.pet_count)
      end
    end
  end
end

