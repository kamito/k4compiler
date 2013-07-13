# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'k4compiler/version'

Gem::Specification.new do |spec|
  spec.name          = "k4compiler"
  spec.version       = K4compiler::VERSION
  spec.authors       = ["Shinichirow Kamito"]
  spec.email         = ["updoor@gmail.com"]
  spec.description   = "k4 compiler"
  spec.summary       = "k4 compiler"
  spec.homepage      = "http://416.bz"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 3.2"
  spec.add_dependency "sass"
  spec.add_dependency "redcarpet"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"

end
