FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "john#{n}" }
    password "password"
    password_confirmation "password"

    factory :invalid_user do
      username nil
      password nil
      password_confirmation nil
    end
  end	
end 
