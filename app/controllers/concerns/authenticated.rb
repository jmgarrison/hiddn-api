module Authenticated
  extend ActiveSupport::Concern

  included do
    before_filter :authenticate
  end

  protected

  def authenticate
    authenticate_with_http_token do |token, options|
      @auth_token = AuthToken.includes(:user).find_by(value: token)
    end
  end

  def auth_token
    @auth_token
  end

  def current_user
    @current_user ||= @auth_token.user
  end

end
