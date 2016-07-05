FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password }
    password_confirmation { |u| u.password }

    trait :with_auth_token do
      after(:create) do |user, evaluator|
        create(:auth_token, user: user)
      end
    end
  end
end
