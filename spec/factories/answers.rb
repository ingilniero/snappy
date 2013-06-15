FactoryGirl.define do
  factory :answer do
    association :question
    association :user
    body { Faker::Lorem.sentence(6) }
  end
end
