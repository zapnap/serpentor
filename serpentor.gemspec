# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serpentor/version'

Gem::Specification.new do |spec|
  spec.name          = "serpentor"
  spec.version       = Serpentor::VERSION
  spec.authors       = ["Nick Plante"]
  spec.email         = ["nap@zerosum.org"]

  spec.summary       = %q{Automates checking of Search Engine Results for a given set of keywords.}
  spec.homepage      = "http://github.com/zapnap/serpentor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.22"
  spec.add_dependency "google-search", "~> 1.0"
end
