
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pixela/version"

Gem::Specification.new do |spec|
  spec.name          = "pixela"
  spec.version       = Pixela::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = %q{Pixela API client for Ruby}
  spec.description   = %q{Pixela API client for Ruby}
  spec.homepage      = "https://github.com/sue445/pixela"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/blob/master/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://sue445.github.io/pixela/"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6.0"

  spec.add_dependency "faraday", ">= 2.0.0"
  spec.add_dependency "faraday_curl"
  spec.add_dependency "faraday-mashify"

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "coveralls_reborn"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "irb"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rdoc"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "term-ansicolor", "!= 1.11.1" # ref. https://github.com/flori/term-ansicolor/issues/41
  spec.add_development_dependency "unparser", ">= 0.4.5"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "yard"
end
