every :day do
  runner 'AuthTokenExpiryWorker.perform_async'
end
