require 'yaml'

module Judge
  class Trainer
    attr_accessor :normal_group, :spam_group, :corpus

    def initialize(normal_group=[], spam_group=[])
      @normal_group = normal_group
      @spam_group = spam_group
      load_corpus
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
          @corpus[word.to_sym] ||= begin
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
          @corpus[word.to_sym] ||= begin
            { spam_prob: @spam_group.freq(word), normal_prob: @normal_group.freq(word) }
          end
        end
      end
    end

    def export_corpus
      File.open(corpus_yaml_file_path, 'w') do |out|
        ::YAML.dump(@corpus, out)
      end
    end

    def load_corpus
      @corpus = ::YAML.load_file(corpus_yaml_file_path) || {}
    end

    def spam?(text)
      item = Item.new(text)
      item.seg!

      score(item.words) > 0.99
    end

    def score(words)
      _probabilities = probabilities(words).sort{|x, y| y <=> x }.first(15)
      combining_probabilities(_probabilities)
    end

    def probabilities(words)
      words.map do |word|
        probs = @corpus[word.to_sym]
        if probs.nil?
          0.4
        else
          word.probability(probs)
        end
      end
    end

    def self.load(corpus_paths={})
      normal_path = corpus_paths[:normal_path] || File.join(Judge.root, 'corpus', 'normal')
      spam_path = corpus_paths[:spam_path] || File.join(Judge.root, 'corpus', 'spam')

      normal_group = Group.load(normal_path)
      spam_group = Group.load(spam_path)

      Trainer.new(normal_group, spam_group)
    end

    private
    def combining_probabilities(probabilities)
      part1 = probabilities.inject(1){|ret, p| ret * p }
      part2 = probabilities.inject(1){|ret, p| ret * ( 1 - p ) }

      part1.to_f / ( part1.to_f + part2.to_f )
    end

    def corpus_yaml_file_path
      @corpus_yaml_file_path ||= begin
        _dir = File.join(Judge.root, 'corpus')
        _path = File.join(_dir, 'corpus.yml')
        Dir.mkdir(_dir) unless Dir.exist?(_dir)
        File.open(_path, 'w'){} unless File.exist? _path
        _path
      end
    end
  end
end