require 'spec_helper'

describe Node do
  it "is invalid without a title" do
    @node = Fabricate(:node)
    @node.title = nil
    @node.should_not be_valid
  end
  it "is invalid without a description" do
    @node = Fabricate(:node)
    @node.description = nil
    @node.should_not be_valid
  end
end

