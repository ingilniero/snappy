FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "john#{n}" }
    password "password"
    password_confirmation "password"
  end	
end 
