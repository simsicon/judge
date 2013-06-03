require "spec_helper"

describe Judge::Stopword do
  let(:stopword){ described_class }

  before do
    stopword.load
  end

  it "should reject stop words" do
    stopword.reject(%w(我 今天 早上 吃了 两个 大烧饼 放了 很多 盐巴)).should include('大烧饼')
  end
end