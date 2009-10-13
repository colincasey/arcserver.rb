require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "arcserver.rb"
    gem.summary = %Q{Library for accessing ESRI ArcServer REST and SOAP APIs.}
    gem.email = "casey.colin@gmail.com"
    gem.homepage = "http://github.com/colincasey/arcserver.rb"
    gem.authors = ["Colin Casey"]
    gem.add_dependency('httparty', '>= 0.4.5')
    gem.add_dependency('handsoap', '>= 1.1.0')
    gem.add_dependency('nokogiri', '>= 1.3.3')
    gem.add_dependency('httpclient', '>= 2.1.5')
    gem.add_development_dependency('jeweler', '>= 1.2.1')
    gem.add_development_dependency('shoulda', '>= 2.10.2')
    gem.add_development_dependency('mocha', '>= 0.9.8')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "arcserver.rb #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

