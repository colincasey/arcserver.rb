# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

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

  s.files = Dir.glob("{lib}/**/*") + %w(LICENSE README.rdoc Rakefile)
  s.test_files = Dir.glob("{test}/**/*")
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]

  s.require_paths = %w[lib]
  s.add_runtime_dependency('activesupport')
  s.add_runtime_dependency('activerecord')
  s.add_runtime_dependency('httparty')
	s.add_runtime_dependency('nokogiri')
	s.add_runtime_dependency('httpclient')
	
	s.add_development_dependency('shoulda')
	s.add_development_dependency('mocha')
  s.add_development_dependency('sdoc')

end
