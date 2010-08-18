$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'fileutils'
require 'arcserver/version'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "arcserver.rb #{ArcServer::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :build do
  system "gem build arcserver.rb.gemspec"

  base_dir = File.dirname(__FILE__)
  pkg_dir = File.join(base_dir, "pkg")
  FileUtils.mkdir_p pkg_dir

  gem_file_name = File.join(base_dir, "arcserver.rb-#{ArcServer::VERSION}.gem")
  FileUtils.mv(gem_file_name, pkg_dir)
end

task :release => :build do
  system "gem push pkg/arcserver.rb-#{ArcServer::VERSION}"
end

