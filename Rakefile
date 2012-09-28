require 'rubygems/package_task'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

task default: :spec

spec = eval(File.read('renmov.gemspec'))
Gem::PackageTask.new(spec).define

Cucumber::Rake::Task.new do |t|
end

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w{--order random}
end
