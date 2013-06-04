require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

$:.unshift(File.dirname(__FILE__) + '/lib')

Dir['tasks/judge.rake'].each { |rake| load rake }