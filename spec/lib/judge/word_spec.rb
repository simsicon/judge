require "spec_helper"

describe Judge::Word do
  subject { described_class.new }

  before do
    subject.count = 0
    subject.spam_prob = 0
    subject.normal_prob = 0
  end

  it "has attributes" do
    subject.count.should == 0
  end

  it "has a spam_prob equal zero" do
    subject.spam_prob.should == 0
  end

  it "has a normal_prob equal zero" do
    subject.normal_prob.should == 0
  end
end
