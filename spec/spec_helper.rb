require "bundler/setup"
require "yuriita"
require "factory_bot_rails"

RSpec.configure do |config|

  Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |path|
    require path
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include(Yuriita::Matchers)
end
