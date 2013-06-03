module Judge
  class Word < String
    attr_accessor :count, :spam_prob, :normal_prob

    def probability(prob={})
      spam_prob = prob[:spam_prob]
      normal_prob = prob[:normal_prob]
      (spam_prob * 0.5)/(spam_prob * 0.5 + normal_prob * 0.5).to_f
    end
  end
end