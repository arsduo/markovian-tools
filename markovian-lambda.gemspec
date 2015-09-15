# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markovian/lambda/version'

Gem::Specification.new do |spec|
  spec.name          = "markovian-lambda"
  spec.version       = Markovian::Lambda::VERSION
  spec.authors       = ["Alex Koppel"]
  spec.email         = ["alex@alexkoppel.com"]

  spec.summary       = %q{An AWS Lambda wrapper for the Markovian gem.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/arsduo/markovian-lambda"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "markovian"
  spec.add_runtime_dependency     "twitter"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
