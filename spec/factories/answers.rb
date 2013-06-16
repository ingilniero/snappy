FactoryGirl.define do
  factory :answer do
    association :question
    association :user
    body { Faker::Lorem.sentence(6) }
  
    factory :invalid_answer do
      body nil
    end
  end
end
