class V1::PlaceTypesController < ApplicationController

  include Authenticated

  respond_to :json

  def index
    @place_types = PlaceType.all
    render json: @place_types
  end

end
