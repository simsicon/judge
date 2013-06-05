require 'yaml'

module Judge
  class Trainer
    attr_accessor :normal_group, :spam_group, :corpus

    def initialize(normal_group=[], spam_group=[])
      @normal_group = normal_group
      @spam_group = spam_group
    end

    def train
      progress = 1
      count = @spam_group.count
      @corpus = {}

      @spam_group.each do |item|
        item.seg!

        puts "#{progress} / #{count}"
        progress += 1

        item.words.each do |word|
          @corpus[word.to_s] ||= begin
            { spam_prob: @spam_group.freq(word), normal_prob: @normal_group.freq(word) }
          end
        end
      end

      progress = 1
      count = @normal_group.count

      @normal_group.each do |item|
        item.seg!

        puts "#{progress} / #{count}"
        progress += 1

        item.words.each do |word|
          @corpus[word.to_s] ||= begin
            { spam_prob: @spam_group.freq(word), normal_prob: @normal_group.freq(word) }
          end
        end
      end
    end

    def export_corpus
      File.open(corpus_yaml_file_path, 'w') do |out|
        out.puts ::YAML.dump(@corpus)
      end
    end

    def self.load(corpus_paths={})
      normal_path = corpus_paths[:normal_path] || File.join(Judge.root, 'corpus', 'normal')
      spam_path = corpus_paths[:spam_path] || File.join(Judge.root, 'corpus', 'spam')

      normal_group = Group.load(normal_path)
      spam_group = Group.load(spam_path)

      Trainer.new(normal_group, spam_group)
    end

  end
end