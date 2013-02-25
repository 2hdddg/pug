# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

# building: gem build .\pug.gemspec
# gem install .\pug-1.gem

Gem::Specification.new do |spec|
  spec.name        = 'pug'
  spec.version     = '0.2.0' #
  spec.licenses    = []
  spec.authors     = ["2hdddg", "wallymathieu"]
  spec.email       = []
  spec.homepage    = "https://github.com/2hdddg/pug"
  spec.summary     = %q{Light-weight issue tracker}
  spec.description = %q{Pug is a simple light-weight distributed issue tracker, main purpose is to automatically create release reports.}

  spec.required_ruby_version     = '>= 1.9.3' 

  spec.files       = Dir.glob('lib/**/*.rb') + Dir.glob('bin\\*.rb')
  spec.executables   = %w(pug.rb pugdiff.rb)
  spec.require_paths = ["lib"]
end