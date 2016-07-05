require 'rails_helper'

RSpec.describe User, type: :model do

  # Associations

  it { should have_many(:auth_tokens) }

  # Validations

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH) }

  describe '#authenticate' do
    let(:password) { 'testing123' }
    let(:user) { FactoryGirl.create(:user, password: password) }

    it 'returns the user with a valid password' do
      expect(user.authenticate(password)).to eq(user)
    end

    it 'returns false with an invalid password' do
      expect(user.authenticate('cats')).to be(false)
    end
  end

  describe '#generate_auth_token!' do
    it 'generates a new AuthToken and sets it to #auth_token' do
      user = FactoryGirl.create(:user)
      expect(user.auth_token).to be_nil

      expect{ user.generate_auth_token! }.to change{ user.auth_tokens.count }.by(1)
      expect(user.auth_token).to eq(user.auth_tokens.last)
    end
  end

end
