class AuthTokenExpiryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AuthToken.expired.destroy_all
  end
end
