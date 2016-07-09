class ApplicationController < ActionController::API

  def render_error(error)
    render json: error, status: error.status
  end

end
