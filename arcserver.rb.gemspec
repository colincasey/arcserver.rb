# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arcserver/version'

Gem::Specification.new do |s|
  s.name = "arcserver.rb"
  s.version = ArcServer::VERSION
	s.license = 'MIT'
  s.authors = ["Luca Simone"]
  s.date = "2013-08-28"
  s.email = ["info@lucasimone.info"]
  s.homepage = "http://github.com/lukefx/arcserver.rb"
  s.summary = "A library for accessing ESRI ArcServer REST APIs from a unified interface"
  s.description = "A library for accessing ESRI ArcServer REST APIs from a unified interface"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'httparty'
	s.add_runtime_dependency 'nokogiri'
	s.add_runtime_dependency 'httpclient'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'rufus-scheduler'
  s.add_runtime_dependency 'rubysl', '~> 2.0' if RUBY_ENGINE = 'rbx'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'sdoc'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'factory_girl'

end
