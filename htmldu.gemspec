# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'htmldu/version'

Gem::Specification.new do |spec|
  spec.name          = "htmldu"
  spec.version       = Htmldu::VERSION
  spec.authors       = ["Takeshi SASAKI"]
  spec.email         = ["dagezi@gmail.com"]

  spec.summary       = %q{Generates HTML showing hierarchical disk usages.}
  spec.description   = %q{Generates HTML showing hierarchical disk usages.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
