# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{arcserver.rb}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Colin Casey"]
  s.date = %q{2009-07-22}
  s.email = %q{casey.colin@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "arcserver.rb.gemspec",
     "lib/arcserver.rb",
     "lib/arcserver/map_server.rb",
     "lib/arcserver/rest/map_server.rb",
     "lib/arcserver/soap/map_server.rb",
     "lib/arcserver/url_helper.rb",
     "test/functional/soap/map_server_test.rb",
     "test/functional/soap/portland_landbase_get_legend_info.yml",
     "test/test_helper.rb",
     "test/unit/map_server_test.rb",
     "test/unit/url_helper_test.rb"
  ]
  s.homepage = %q{http://github.com/colincasey/arcserver.rb}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{TODO}
  s.test_files = [
    "test/test_helper.rb",
     "test/functional/soap/map_server_test.rb",
     "test/unit/url_helper_test.rb",
     "test/unit/map_server_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
