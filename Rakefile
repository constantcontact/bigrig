require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'rake/clean'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: [:spec, :rubocop]
