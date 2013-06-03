# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'judge/version'

Gem::Specification.new do |spec|
  spec.name          = "judge"
  spec.version       = Judge::VERSION
  spec.authors       = ["simsicon"]
  spec.email         = ["simsicon@gmail.com"]
  spec.description   = "To judge a text whether spam based on corpus"
  spec.summary       = "To judge a text whether spam based on corpus"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rmmseg-cpp", "~> 0.2.9"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.13.0'
end
