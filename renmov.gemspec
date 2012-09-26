$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'renmov/version'

Gem::Specification.new do |s|
  s.name        = 'renmov'
  s.version     = Renmov::VERSION
  s.authors     = ['Brian Blumberg']
  s.description = 'Rename video files to a consistent format.'
  s.summary     = "renmov-#{s.version}"
  s.email       = 'blumbri@gmail.com'
  s.homepage    = 'http://github.com/blumbri/renmov'

  s.platform    = Gem::Platform::RUBY

  s.files       = `git ls-files`.split("\n").reject { |p| p =~ /\.gitignore$/ }
  s.test_files  = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.add_development_dependency('rspec')
  s.add_development_dependency('cucumber')
  s.add_development_dependency('aruba')
end
