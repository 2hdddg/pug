require 'bundler'
require 'bundler/gem_tasks'
Bundler.setup
$:.unshift File.expand_path("../pug", __FILE__)
require 'pug'
require "pugversion"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/tc_*.rb']
  t.verbose = true
end

task :build do
	system "gem build pug.gemspec"
end

task :install => :build do
	system "sudo gem install pug-#{Pug::VERSION}.gem"
end

task :default => :test