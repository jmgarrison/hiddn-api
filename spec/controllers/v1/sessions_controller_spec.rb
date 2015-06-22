require 'rails_helper'

RSpec.describe V1::SessionsController, type: :controller do

  it_behaves_like 'an authenticated controller'

  describe 'POST create' do

    let(:user) { FactoryGirl.create(:user) }

    it 'is routable via POST /v1/sessions' do
      expect(post: '/v1/sessions').to route_to(controller: 'v1/sessions', action: 'create')
    end

    describe 'with valid user credentials' do
      it 'responds with the user and auth token' do
        request = -> { post :create, user: { email: user.email, password: user.password } }
        expect(request).to change{ user.auth_tokens.count }.by(1)
        expect(response).to have_http_status(:created)

        auth_token = user.auth_tokens.last
        user.auth_token = auth_token
        expected_json = UserSerializer.new(user).to_json
        expect(response.body).to eq(expected_json)
      end
    end

    describe 'with invalid user credentials' do
      it 'responds with not acceptable response with an invalid password' do
        request = -> { post :create, user: { email: user.email, password: user.password + "foo" } }
        expect(request).to_not change{ user.auth_tokens.count }
        expect(response).to have_http_status(:not_acceptable)

        expected_json = InvalidCredentialsError.to_json
        expect(response.body).to eq(expected_json)
      end

      it 'responds with not acceptable response with an invalid password' do
        request = -> { post :create, user: { email: 'doesnot@exist.com', password: 'bar' } }
        expect(request).to_not change{ user.auth_tokens.count }
        expect(response).to have_http_status(:not_acceptable)

        expected_json = InvalidCredentialsError.to_json
        expect(response.body).to eq(expected_json)
      end
    end

  end

  describe 'DELETE destroy' do

    include_context 'authenticated'

    it 'is routable via DELETE /v1/sessions' do
      expect(delete: '/v1/sessions').to route_to(controller: 'v1/sessions', action: 'destroy')
    end

    it 'destroys the auth token from the Authorization header' do
      delete :destroy
      expect(response).to have_http_status(:no_content)
      expect(AuthToken.exists?(auth_token.id)).to eq(false)
    end

    it 'succeeds for an auth token that does not exist' do
      delete :destroy
      expect(response).to have_http_status(:no_content)
    end
  end

end
