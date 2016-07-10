require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  controller do
    include Authenticated

    def index
      render head: true
    end
  end

  include_context 'authenticated'

  it 'authenticates all requests' do
    expect(controller).to receive(:authenticate).once
    get :index
  end

  describe '#authenticate' do
    it 'assigns the auth token from the http token' do
      controller.send(:authenticate)
      expect(controller.send(:auth_token)).to eq(auth_token)
    end
  end

  describe '#auth_token' do
    it 'returns the auth token from the request' do
      get :index
      expect(controller.send(:auth_token)).to eq(auth_token)
    end
  end

  describe '#current_user' do
    it 'returns the user with the auth token from the request' do
      get :index
      expect(controller.send(:current_user)).to eq(user)
    end
  end

end
