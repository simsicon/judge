require "spec_helper"

describe Judge::Item do
  let(:text) { "太阳当空照" }
  let(:item) { Judge::Item.new(text) }

  describe ".seg" do
    it "should segment to words" do
      Judge::Item.seg(text).should include("太阳")
    end
  end
end