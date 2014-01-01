# -*- coding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wikipedia/anime/version'

Gem::Specification.new do |spec|
  spec.name          = "wikipedia-anime"
  spec.version       = Wikipedia::Anime::VERSION
  spec.authors       = ["mochiz"]
  spec.email         = ["mochi.hiro43@gmail.com"]
  spec.description   = %q{Ruby client for the Wikipedia APIn specialized Anime}
  spec.summary       = %q{Ruby client for the Wikipedia APIn specialized Anime}
  spec.homepage      = "https://github.com/mochiz/wikipedia-anime"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("wikipedia-client", ['~> 1.3.0'])

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency('rspec', ['~> 2.13'])
  spec.add_development_dependency('webmock', ['~> 1.11'])
  spec.add_development_dependency('coveralls')
  spec.add_development_dependency('simplecov')
end
