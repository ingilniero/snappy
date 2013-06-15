FactoryGirl.define do
  factory :question do
    association :user
    body { Faker::Lorem.sentence(5) }
    solved false
  end
end

