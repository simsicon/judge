require "spec_helper"

describe Judge::Group do
  let(:group) do
    described_class.new()
  end

  before do
    %w(正确识别垃圾邮件的技术难度非常大 传统的垃圾邮件过滤方法 主要有"关键词法"和"校验码法"等 前者的过滤依据是特定的词语).each do |str|
      group << Judge::Item.new(str)
    end
  end

  it { group.should respond_to(:all?, :any?, :map, :each, :count) }

  it "calculate freq of word" do
    group.freq("垃圾").should == 0.5
  end

  it "probability not zero" do
    group.freq("青瓜").should_not == 0.0
    group.freq("青瓜").should == 0.0001
  end
end