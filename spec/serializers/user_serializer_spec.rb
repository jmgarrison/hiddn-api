require 'rails_helper'

RSpec.describe UserSerializer do

  let(:user) { FactoryGirl.create(:user) }

  subject(:user_json) { JSON.parse(serialize_object(user))['data']['attributes'] }

  it { should have_key('auth-token') }
  it { should have_key('auth-token-expires-at') }
  it { should have_key('email') }
  it { should have_key('first-name') }
  it { should have_key('last-name') }

  describe 'auth-token' do
    it 'is set when set on user' do
      user.auth_token = user.auth_tokens.create
      expect(user_json['auth-token']).to eq(user.auth_token.value)
    end

    it 'is set to null when auth-token is not set on user' do
      expect(user_json['auth-token']).to be_nil
    end
  end

  describe 'auth-token-expires-at' do
    it 'is set when the auth_token when set on user' do
      user.auth_token = user.auth_tokens.create
      expect(user_json['auth-token-expires-at']).to eq(user.auth_token.expires_at.as_json)
    end

    it 'is set to null when auth_token is not set on user' do
      expect(user_json['auth-token-expires-at']).to be_nil
    end
  end

end
