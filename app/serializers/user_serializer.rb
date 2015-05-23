class UserSerializer < BaseSerializer

  attributes :auth_token, :auth_token_expires_at, :email, :first_name, :last_name

  def auth_token
    object.auth_token.try(:value)
  end

  def auth_token_expires_at
    object.auth_token.try(:expires_at)
  end

end
