Raven.configure do |config|
  config.dsn = ENV.fetch("SENTRY_DSN", "")
end
