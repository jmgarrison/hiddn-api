require 'rails_helper'

RSpec.describe UserSerializer do

  let(:user) { FactoryGirl.create(:user) }
  let(:serializer) { UserSerializer.new(user).to_json }

  subject(:user_json) { JSON.parse(serializer)['user'] }

  it { should have_key('auth_token') }
  it { should have_key('auth_token_expires_at') }
  it { should have_key('email') }
  it { should have_key('first_name') }
  it { should have_key('last_name') }

  describe 'auth_token' do
    it 'is set when set on user' do
      user.auth_token = user.auth_tokens.create
      json = JSON.parse(serializer)
      expect(json['user']['auth_token']).to eq(user.auth_token.value)
    end

    it 'is set to null when auth_token is not set on user' do
      json = JSON.parse(serializer)
      expect(json['user']['auth_token']).to be_nil
    end
  end

  describe 'auth_token_expires_at' do
    it 'is set when the auth_token when set on user' do
      user.auth_token = user.auth_tokens.create
      json = JSON.parse(serializer)
      expect(json['user']['auth_token_expires_at']).to eq(user.auth_token.expires_at.as_json)
    end

    it 'is set to null when auth_token is not set on user' do
      json = JSON.parse(serializer)
      expect(json['user']['auth_token_expires_at']).to be_nil
    end
  end

end
