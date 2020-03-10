source "https://rubygems.org"

# Specify your gem"s dependencies in yuri-ita.gemspec
gemspec

ruby "2.6.5"

gem "rails"

gem "bootsnap", ">= 1.4.4", require: false
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.3"
gem "sass-rails", ">= 6"
gem "sentry-raven"

group :test, :development do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "webdrivers"
end
