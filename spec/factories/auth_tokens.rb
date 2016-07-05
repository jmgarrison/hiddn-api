FactoryGirl.define do
  factory :auth_token do
    user

    trait :expired do
      after(:create) do |auth_token, evaluator|
        auth_token.update_attribute(:expires_at, Time.zone.now - 5.days)
      end
    end
  end
end
