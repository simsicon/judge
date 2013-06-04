require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

Dir['tasks/judge.rake'].each { |rake| load rake }