lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yuriita/version"

Gem::Specification.new do |spec|
  spec.name = "yuri-ita"
  spec.version = Yuriita::VERSION
  spec.authors = ["Louis Antonopoulos", "Sally Hall", "Eebs Kobeissi"]
  spec.email = ["louis@thoughtbot.com"]

  spec.summary = "Filter and search using an expressive, user defined, query language"
  spec.homepage = "https://github.com/thoughtbot/yuri-ita"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/thoughtbot/yuri-ita/blob/main/NEWS.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir["{lib}/**/*", "LICENSE"]
  spec.license = "LicenseRef-LICENSE"

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = "~> 3.1"

  spec.add_dependency "rltk", "~> 3.0"
  spec.add_dependency "activesupport", "~> 7.0"
  spec.add_dependency "activerecord", "~> 7.0"
  spec.add_dependency "activemodel", ">= 7", "< 9"
  spec.add_dependency "zeitwerk", "~> 2.6"

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  spec.add_development_dependency "pry-rails", "~> 0.3.7"
end
