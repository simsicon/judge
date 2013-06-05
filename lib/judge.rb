require "judge/version"
require 'judge/path'
require "judge/stopword"
require "judge/word"
require "judge/item"
require "judge/group"
require "judge/trainer"
require "judge/railtie" if defined?(Rails)

require 'rmmseg'

RMMSeg::Dictionary.load_dictionaries
Judge::Stopword.load

module Judge
  class <<self

    def load_corpus
      @corpus ||= (::YAML.load_file(Judge.corpus_yaml_file_path) || {})
    end

    def spam?(text)
      load_corpus
      item = Item.new(text)
      item.seg!

      score(item.words) > 0.99
    end

    def score(words)
      _probabilities = probabilities(words).sort{|x, y| y <=> x }.first(15)
      combining_probabilities(_probabilities)
    end

    private
    def probabilities(words)
      words.map do |word|
        probs = @corpus[word.to_s]
        if probs.nil?
          0.4
        else
          word.probability(probs)
        end
      end
    end

    def combining_probabilities(ps)
      part1 = ps.inject(1){|ret, p| ret * p }
      part2 = ps.inject(1){|ret, p| ret * ( 1 - p ) }

      part1.to_f / ( part1.to_f + part2.to_f )
    end

  end
end