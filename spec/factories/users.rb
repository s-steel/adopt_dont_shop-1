FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
  end 

  trait :with_reviews do
    transient do
      number_of_reviews { 3 }
    end

    after(:create) do |user, evaluator|
      create_list(:review, evaluator.number_of_reviews, user: user)
    end
  end

  trait :with_applications do
    transient do
      number_of_applications { 3 }
    end

    after(:create) do |user, evaluator|
      create_list(:user_application, evaluator.number_of_applications, user: user)
    end
  end
end
