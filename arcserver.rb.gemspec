# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'arcserver/version'

Gem::Specification.new do |s|
  s.name = "arcserver.rb"
  s.version = ArcServer::VERSION
  s.authors = ["Colin Casey"]
  s.date = "2010-08-18"
  s.email = ["casey.colin@gmail.com"]
  s.homepage = "http://github.com/colincasey/arcserver.rb"
  s.summary = "Library for accessing ESRI ArcServer REST and SOAP APIs."
  s.description = "arcserver.rb is a utility for accessing ESRI ArcServer REST and SOAP APIs from a unified interface"

  s.files = Dir.glob("{lib}/**/*") + %w(LICENSE README.rdoc Rakefile)
  s.test_files = Dir.glob("{test}/**/*")
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = "1.3.4"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.4.5"])
      s.add_runtime_dependency(%q<handsoap>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.3.3"])
      s.add_runtime_dependency(%q<httpclient>, [">= 2.1.5"])
      s.add_development_dependency(%q<shoulda>, [">= 2.10.2"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_development_dependency(%q<rmagick>, [">= 2.13.1"])
    else
      s.add_dependency(%q<httparty>, [">= 0.4.5"])
      s.add_dependency(%q<handsoap>, [">= 1.1.0"])
      s.add_dependency(%q<nokogiri>, [">= 1.3.3"])
      s.add_dependency(%q<httpclient>, [">= 2.1.5"])
      s.add_dependency(%q<shoulda>, [">= 2.10.2"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_dependency(%q<rmagick>, [">= 2.13.1"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.4.5"])
    s.add_dependency(%q<handsoap>, [">= 1.1.0"])
    s.add_dependency(%q<nokogiri>, [">= 1.3.3"])
    s.add_dependency(%q<httpclient>, [">= 2.1.5"])
    s.add_dependency(%q<shoulda>, [">= 2.10.2"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
    s.add_dependency(%q<rmagick>, [">= 2.13.1"])
  end
end
