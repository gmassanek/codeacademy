require 'spec_helper'

describe Node do
  it "belongs to the Ruby Ecosystem by default" do
    @node = Fabricate(:node)
    @node.ecosystem.should == 'Ruby'
  end
end

