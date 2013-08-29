$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rake'
require 'rspec/core/rake_task'
require 'fileutils'
require 'arcserver/version'

task :default => :spec

RSpec::Core::RakeTask.new('spec')

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']
  end
rescue LoadError

end

desc "Build arcserver.rb gem"
task :build do
  system "gem build arcserver.rb.gemspec"

  base_dir = File.dirname(__FILE__)
  pkg_dir = File.join(base_dir, "pkg")
  FileUtils.mkdir_p pkg_dir

  gem_file_name = File.join(base_dir, "arcserver.rb-#{ArcServer::VERSION}.gem")
  FileUtils.mv(gem_file_name, pkg_dir)
end

desc "Release arcserver.rb gem"
task :release => :build do
  system "gem push pkg/arcserver.rb-#{ArcServer::VERSION}"
end
