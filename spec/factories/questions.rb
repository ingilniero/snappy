FactoryGirl.define do
  factory :question do
    association :user
    body { Faker::Lorem.sentence(5) }
    solved false
  
    factory :invalid_question do
      body nil
    end
  end
end

