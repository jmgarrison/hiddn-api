require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do

  describe 'POST create' do

    let(:user) { assigns(:user) }
    let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

    it 'responds with the user and auth token with valid parameters' do
      user_count = User.count
      auth_token_count = AuthToken.count

      expect { post :create, user: valid_attributes }.to change{ User.count }.by(1)
      expect(response).to have_http_status(:created)

      expect(User.count).to eq(user_count + 1)
      expect(AuthToken.count).to eq(auth_token_count + 1)

      auth_token = user.auth_tokens.last
      expected_json = UserSerializer.new(user).to_json
      expect(response.body).to eq(expected_json)
      expect(user.auth_token).to_not be_nil
      expect(user.auth_token).to eq(auth_token)
    end

    it 'responds with a validation error with invalid response' do
      user_count = User.count
      auth_token_count = AuthToken.count

      post :create, user: valid_attributes.except(:email)

      expect(response).to have_http_status(:not_acceptable)

      expect(User.count).to eq(user_count)
      expect(AuthToken.count).to eq(auth_token_count)

      expect(user.errors).to_not be_blank
      expect(response.body).to eq(UserSerializer.new(user).to_json)
    end

  end

end
