require 'rails_helper'

RSpec.describe V1::PlaceTypesController, type: :controller do

  it_behaves_like 'an authenticated controller'

  describe 'GET index' do

    include_context 'authenticated'

    it 'is routable via GET /v1/place_types' do
      expect(get: '/v1/place_types').to route_to(controller: 'v1/place_types', action: 'index')
    end

    it 'returns all valid place types and their values' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(PlaceType.all.to_json)
    end

  end

end
