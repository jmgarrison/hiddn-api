require 'rails_helper'

RSpec.describe User, type: :model do

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

end
