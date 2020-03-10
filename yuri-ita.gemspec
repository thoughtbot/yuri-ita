lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yuriita/version"

Gem::Specification.new do |spec|
  spec.name          = "yuri-ita"
  spec.version       = Yuriita::VERSION
  spec.authors       = ["Eebs Kobeissi"]
  spec.email         = ["ebrahim.kobeissi@gmail.com"]

  spec.summary       = %q{Filter and search using an expressive, user defined, query language}
  spec.homepage      = "https://github.com/eebs/yuri-ita"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/eebs/yuri-ita"
  spec.metadata["changelog_uri"] = "https://github.com/eebs/yuri-ita/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files         = Dir["{lib}/**/*", "LICENSE"]

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rltk"
  spec.add_dependency "activesupport", ">= 4.2"
  spec.add_dependency "activerecord", ">= 4.2"
  spec.add_dependency "activemodel", ">= 4.2"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  spec.add_development_dependency "pry-rails"
end
