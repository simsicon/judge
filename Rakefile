require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

require './lib/judge'

desc 'Train corpus'
task :train_and_export_corpus do
  trainer = Judge::Trainer.load({normal_path: ENV['NORMAL_PATH'], spam_path: ENV['SPAM_PATH']})
  trainer.train
  trainer.export_corpus
end