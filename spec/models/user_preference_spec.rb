require 'rails_helper'

RSpec.describe UserPreference, type: :model do

  subject(:user_preference) { build(:user_preference) }

  # Associations

  it { should belong_to(:user) }

  # Validations

  it { should validate_presence_of(:min_rating) }
  it { should validate_presence_of(:types) }

  describe '#min_rating_within_range_and_step' do

    let(:error) { I18n.t(translation_key, min: UserPreference::MIN_RATING_VALUE, max: UserPreference::MAX_RATING_VALUE, step: UserPreference::RATING_STEP) }
    let(:translation_key) { 'activerecord.errors.models.user_preference.attributes.min_rating.inclusion' }

    it 'allows values between MIN_RATING_VALUE and MAX_RATING_VALUE with a step of RATING_STEP' do
      UserPreference.rating_values.each do |rating|
        user_preference.min_rating = rating
        expect(user_preference).to be_valid
      end
    end

    it 'does not allow values outside of MIN_RATING_VALUE and MAX_RATING_VALUE' do
      user_preference.min_rating = UserPreference::MIN_RATING_VALUE - 0.1
      expect(user_preference).to_not be_valid
      expect(user_preference.errors[:min_rating]).to include(error)

      user_preference.min_rating = UserPreference::MAX_RATING_VALUE + 0.1
      expect(user_preference).to_not be_valid
      expect(user_preference.errors[:min_rating]).to include(error)
    end

    it 'does not allow values that are not within RATING_STEP' do
      user_preference.min_rating = UserPreference::MIN_RATING_VALUE + 0.12
      expect(user_preference).to_not be_valid
      expect(user_preference.errors[:min_rating]).to include(error)

      user_preference.min_rating = UserPreference::MAX_RATING_VALUE - 0.34
      expect(user_preference).to_not be_valid
      expect(user_preference.errors[:min_rating]).to include(error)
    end
  end

  # Callbacks

  describe 'before_validation' do
    it 'whitelists the place type values with valid place type values' do
      user_preference.types = PlaceType.keys
      expect(user_preference).to be_valid
      user_preference.types << 'foo'
      expect(user_preference).to be_valid
      expect(user_preference.types).to eq(PlaceType.keys)
    end
  end

  describe '.rating_values' do
    it 'returns an array of values between MIN_RATING_VALUE and MAX_RATING_VALUE' do
      min, max, step = UserPreference::MIN_RATING_VALUE, UserPreference::MAX_RATING_VALUE, UserPreference::RATING_STEP
      expected = (min..max).step(step).to_a
      expect(UserPreference.rating_values).to eq(expected)
    end
  end

end
