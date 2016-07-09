class InvalidCredentialsError < ResponseError

  detail :invalid_credentials
  status :not_acceptable

end
