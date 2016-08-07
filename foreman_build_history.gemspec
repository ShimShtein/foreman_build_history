require File.expand_path('../lib/foreman_build_history/version', __FILE__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'foreman_build_history'
  s.version     = ForemanBuildHistory::VERSION
  s.date        = Date.today
  s.authors     = ['Shim Shtein']
  s.email       = ['shteinshim@gmail.com']
  s.homepage    = 'http://github.com'
  s.summary     = 'Summary of ForemanBuildHistory.'
  # also update locale/gemspec.rb
  s.description = 'Description of ForemanBuildHistory.'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'deface'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
