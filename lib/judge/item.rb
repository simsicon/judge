module Judge
  class Item < String
    attr_accessor :words

    def seg!
      _words = self.class.seg(self.to_s.gsub(/\@\S+/, '').gsub(/http:\/\/\S+/, '')).map{|w| Word.new(w)}
      @words = Judge::Stopword.reject(_words)
    end

    def self.seg(text)
      algor = RMMSeg::Algorithm.new(text)
      result = []
      while tok = algor.next_token
        result << tok.text.force_encoding(Encoding::UTF_8)
      end
      result
    end
  end
end