require 'judge'

namespace :judge do
  desc "Train corpus"
  task :train_and_export_corpus, :normal_path, :spam_path do |_t, args|
    if args[:normal_path] && args[:spam_path]
      trainer = Judge::Trainer.load(args)
      trainer.train
      trainer.export_corpus
    end
  end
end