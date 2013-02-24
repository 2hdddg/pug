require 'bundler'
Bundler.setup
$:.unshift File.expand_path("../pug", __FILE__)
require 'pug'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/tc_*.rb']
  t.verbose = true
end