# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'k7/version'

Gem::Specification.new do |spec|
  spec.name          = 'k7'
  spec.version       = K7::VERSION
  spec.authors       = ['Romeu Fonseca']
  spec.email         = ['romeu.hcf@gmail.com']

  spec.summary       = 'Lightweight VCR.'
  spec.description   = 'Smaller outgoing http request recorder'
  spec.homepage      = 'http://github.com/romeuhcf/k7'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'typhoeus'
  spec.add_development_dependency 'excon'
  spec.add_development_dependency 'faraday'
  spec.add_development_dependency 'guard', '< 2'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'thin'
  if RUBY_VERSION >= '2.0.0'
    spec.add_development_dependency 'byebug'
  else
    spec.add_development_dependency 'pry'
    spec.add_development_dependency 'pry-debugger'
  end
end
