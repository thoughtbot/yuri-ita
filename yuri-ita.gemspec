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
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rltk"
  spec.add_dependency "activesupport", ">= 4.2"
  spec.add_dependency "activerecord", ">= 4.2"
  spec.add_dependency "activemodel", ">= 4.2"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
end
