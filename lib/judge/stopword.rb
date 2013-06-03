module Judge
  class Stopword
    CHINESE_DICT_PATH = File.join Judge.root, 'dicts', 'chinese_stopwords.txt'
    ENGLISH_DICT_PATH = File.join Judge.root, 'dicts', 'english_stopwords.txt'

    class <<self
      def load
        @words = []
        load_dict(CHINESE_DICT_PATH)
        load_dict(ENGLISH_DICT_PATH)
      end

      def reject(words)
        # for every word that is not single character and not a username and is not a stopword
        words.select { |word| !single_character?(word) && !username?(word) && !is?(word) }
      end

      # add a stopword (TODO: rename)
      def add(word)
        @words << word
      end

      # remove all the stopwords by removing the set
      def flush
        @words = []
      end

      # is this a stopwxord?
      def is?(word)
        @words.include? word
      end

      # is this a single character word?
      def single_character?(word)
        word.length == 1
      end

      # tencent usernames start with @
      def username?(word)
        word[0] == '@'
      end

      private
      def load_dict(filename)
        File.open(filename, 'r') do |file|
          file.each_line do |line|
            add(line.strip)
          end
        end
      end
    end
  end
end