source "https://rubygems.org"

# Specify your gem"s dependencies in yuri-ita.gemspec
gemspec

ruby "3.3.4"

gem "rails"

gem "bootsnap", ">= 1.4.4", require: false
gem "bourbon"
gem "github-markup", require: "github/markup"
gem "jsbundling-rails"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 6.4"
gem "redcarpet"
gem "sass-rails", ">= 6"
gem "sentry-raven"
gem "themoviedb-api"

group :test, :development do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
end
