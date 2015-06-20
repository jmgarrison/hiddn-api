class InvalidCredentialsError < ResponseError

  message :invalid_credentials
  status :not_acceptable

end
