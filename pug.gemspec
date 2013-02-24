# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'bundler/version'

# building: gem build .\pug.gemspec
# gem install .\pug-1.gem

Gem::Specification.new do |spec|
  spec.name        = 'pug'
  spec.version     = '0.2.0' #
  spec.licenses    = []
  spec.authors     = ["2hdddg"]
  spec.email       = []
  spec.homepage    = "https://github.com/2hdddg/pug"
  spec.summary     = %q{Light-weight issue tracker}
  spec.description = %q{Pug is a simple light-weight distributed issue tracker that handles what's released on a server.}

  spec.required_ruby_version     = '>= 1.9.3' 

  spec.files       = Dir.glob('lib/**/*.rb')+Dir.glob('bin\\*.rb')
  spec.test_files  = spec.files.grep(%r{^test/})

  spec.executables   = %w(pug.rb pugdiff.rb)
  spec.require_paths = ["lib"]
end