class AuthTokenExpiryWorker

  include Sidekiq::Worker

  def perform
    AuthToken.expired.destroy_all
  end

end
