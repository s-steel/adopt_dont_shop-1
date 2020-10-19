FactoryBot.define do
  factory :review do
    title { Faker::Lorem.sentence(word_count: 3) }
    rating { 4 }
    content { Faker::Lorem.paragraph(sentence_count: 2) }

    shelter
    user
  end
end

