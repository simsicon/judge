require 'spec_helper'

describe Judge::Trainer do
  let(:trainer) do
    _normal_items = %w(正确识别垃圾邮件的技术难度非常大 传统的垃圾邮件过滤方法 主要有"关键词法"和"校验码法"等 前者的过滤依据是特定的词语).map{|text| Judge::Item.new(text)}
    _spam_items = %w(睡睡瘦 小S产后亲身使用 睡觉前贴在肚子上就能瘦 根本不用口服木有半点副作用 一个月痩15斤也不是梦).map{|text| Judge::Item.new(text)}
    _normal_group = Judge::Group.new(_normal_items)
    _spam_group = Judge::Group.new(_spam_items)
    Judge::Trainer.new(_normal_group, _spam_group)
  end

  it "train corpus" do
    trainer.train
    trainer.corpus.class.should be Hash
    trainer.corpus.should_not be_empty
  end

end