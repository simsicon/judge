module Judge
  def self.root
    File.expand_path '../..', __FILE__
  end
end

require "judge/version"
require "judge/stopword"
require "judge/word"
require "judge/item"
require "judge/group"
require "judge/trainer"
require "judge/railtie" if defined?(Rails)

require 'rmmseg'

RMMSeg::Dictionary.load_dictionaries
Judge::Stopword.load
