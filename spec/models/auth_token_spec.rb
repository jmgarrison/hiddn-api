require 'rails_helper'

RSpec.describe AuthToken, type: :model do

  # Associations

  it { should belong_to(:user) }

  # Validations

  it { should validate_presence_of(:user) }

  it 'validates expires_at is before now on create' do
    auth_token = nil
    Timecop.freeze(now = Time.zone.now) do
      auth_token = FactoryGirl.build(:auth_token, expires_at: now - 1.second)
    end

    error = I18n.t('activerecord.errors.models.auth_token.attributes.expires_at.in_past', now: now.to_s)
    expect(auth_token.valid?).to eq(false)
    expect(auth_token.errors[:expires_at]).to include(error)
  end

  # Callbacks

  describe 'before_validation' do

    let(:token) { AuthToken.create!(user: FactoryGirl.create(:user)) }

    it 'generates a value if one does not exist' do
      expect(token.value).to_not be_nil
    end

    it 'does not regenerate the value on update' do
      value = token.value
      token.save
      expect(token.value).to eq(value)
    end

    it 'sets expires_at on create' do
      Timecop.freeze(now = Time.zone.now) do
        token
        expect(token.expires_at).to eq(now + AuthToken::DEFAULT_DURATION)
      end
    end

  end

end
