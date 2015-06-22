FactoryGirl.define do
  factory :user_preference do
    sequence(:min_rating) do |n|
      min = UserPreference::MIN_RATING_VALUE
      step = UserPreference::RATING_STEP * n
      min + step % UserPreference::MAX_RATING_VALUE
    end

    types { PlaceType.keys.first(5) }
    user
  end
end
