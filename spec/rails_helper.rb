ENV["RAILS_ENV"] = "test"

require File.expand_path("../../spec/example_app/config/environment", __FILE__)

require "rspec/rails"
require "capybara/rails"
require "capybara/rspec"
require 'pry'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |path|
  require path
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
end

ActiveRecord::Migration.maintain_test_schema!
