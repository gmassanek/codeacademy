require 'spec_helper'

describe Tutorial do
  it "requires a node" do
    @siteHandle = Fabricate(:tutorial)
    @siteHandle.should be_valid
    @siteHandle.node = nil
    @siteHandle.should_not be_valid
  end
end

